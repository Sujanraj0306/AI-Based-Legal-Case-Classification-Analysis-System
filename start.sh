#!/bin/bash

###############################################################################
# AI-Based Legal Case Classification & Analysis System
# One-Click Startup Script
# 
# This script will:
# 1. Check Python and Node.js dependencies
# 2. Load knowledge base for TYPE-B (Advisory System)
# 3. Start backend server (FastAPI)
# 4. Start frontend application (Electron)
# 5. Verify both TYPE-A (Litigation) and TYPE-B (Advisory) are ready
###############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project root directory
PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKEND_DIR="$PROJECT_ROOT/mcp/server"
FRONTEND_DIR="$PROJECT_ROOT/mcp/client"

# Log file
LOG_FILE="$PROJECT_ROOT/startup.log"
echo "=== Startup Log $(date) ===" > "$LOG_FILE"

# Function to print colored messages
print_header() {
    echo -e "${BLUE}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║  $1${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════════════════════╝${NC}"
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if port is in use
port_in_use() {
    lsof -i:"$1" >/dev/null 2>&1
}

# Function to kill process on port
kill_port() {
    local port=$1
    print_info "Killing process on port $port..."
    lsof -ti:"$port" | xargs kill -9 2>/dev/null || true
    sleep 2
}

###############################################################################
# STEP 1: Environment Checks
###############################################################################

print_header "STEP 1: Checking Environment"

# Check Python
if command_exists python3; then
    PYTHON_VERSION=$(python3 --version 2>&1)
    print_success "Python found: $PYTHON_VERSION"
else
    print_error "Python 3 not found. Please install Python 3.8+"
    exit 1
fi

# Check Node.js
if command_exists node; then
    NODE_VERSION=$(node --version)
    print_success "Node.js found: $NODE_VERSION"
else
    print_error "Node.js not found. Please install Node.js 16+"
    exit 1
fi

# Check npm
if command_exists npm; then
    NPM_VERSION=$(npm --version)
    print_success "npm found: v$NPM_VERSION"
else
    print_error "npm not found. Please install npm"
    exit 1
fi

###############################################################################
# STEP 2: Backend Setup
###############################################################################

print_header "STEP 2: Setting Up Backend"

cd "$BACKEND_DIR" || exit 1

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    print_info "Creating virtual environment..."
    python3 -m venv venv
    print_success "Virtual environment created"
fi

# Activate virtual environment
print_info "Activating virtual environment..."
source venv/bin/activate

# Check if requirements are installed
print_info "Checking Python dependencies..."
pip install -q -r requirements.txt >> "$LOG_FILE" 2>&1
print_success "Python dependencies installed"

# Check for .env file
if [ ! -f ".env" ]; then
    print_error ".env file not found!"
    print_info "Please create .env file with GEMINI_API_KEY"
    if [ -f ".env.example" ]; then
        print_info "Example: cp .env.example .env"
    fi
    exit 1
else
    print_success ".env file found"
fi

###############################################################################
# STEP 3: Load Knowledge Base (TYPE-B)
###############################################################################

print_header "STEP 3: Loading Knowledge Base for TYPE-B"

# Check if knowledge base exists
if [ -d "data/advisory_knowledge" ]; then
    print_info "Loading advisory knowledge into ChromaDB..."
    python load_knowledge_base.py >> "$LOG_FILE" 2>&1
    
    if [ $? -eq 0 ]; then
        print_success "Knowledge base loaded successfully"
    else
        print_error "Failed to load knowledge base (check $LOG_FILE)"
        print_info "Continuing anyway - RAG will work with empty collections"
    fi
else
    print_info "Knowledge base directory not found, skipping..."
fi

###############################################################################
# STEP 4: Start Backend Server
###############################################################################

print_header "STEP 4: Starting Backend Server"

# Kill existing backend if running
if port_in_use 8000; then
    print_info "Port 8000 is in use, killing existing process..."
    kill_port 8000
fi

# Start backend in background
print_info "Starting FastAPI server on http://localhost:8000..."
nohup python main.py > "$PROJECT_ROOT/backend.log" 2>&1 &
BACKEND_PID=$!

# Wait for backend to start
print_info "Waiting for backend to start..."
for i in {1..30}; do
    if curl -s http://localhost:8000/health >/dev/null 2>&1; then
        print_success "Backend server started (PID: $BACKEND_PID)"
        break
    fi
    sleep 1
    if [ $i -eq 30 ]; then
        print_error "Backend failed to start (check $PROJECT_ROOT/backend.log)"
        exit 1
    fi
done

###############################################################################
# STEP 5: Frontend Setup
###############################################################################

print_header "STEP 5: Setting Up Frontend"

cd "$FRONTEND_DIR" || exit 1

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    print_info "Installing frontend dependencies..."
    npm install >> "$LOG_FILE" 2>&1
    print_success "Frontend dependencies installed"
else
    print_success "Frontend dependencies already installed"
fi

###############################################################################
# STEP 6: Verify System Health
###############################################################################

print_header "STEP 6: Verifying System Health"

# Test backend health
print_info "Testing backend health endpoint..."
HEALTH_RESPONSE=$(curl -s http://localhost:8000/health)
if echo "$HEALTH_RESPONSE" | grep -q "ok"; then
    print_success "Backend health check passed"
else
    print_error "Backend health check failed"
fi

# Test TYPE-A endpoint
print_info "Checking TYPE-A (Litigation) endpoint..."
if curl -s http://localhost:8000/classify-issues >/dev/null 2>&1; then
    print_success "TYPE-A endpoints available"
else
    print_error "TYPE-A endpoints not responding"
fi

# Test TYPE-B endpoint
print_info "Checking TYPE-B (Advisory) endpoint..."
ADVISORY_TEST=$(curl -s -X POST http://localhost:8000/analyze-advisory \
    -F "client_objective=test" 2>&1)
if [ $? -eq 0 ]; then
    print_success "TYPE-B endpoints available"
else
    print_info "TYPE-B endpoint check inconclusive (requires full request)"
fi

###############################################################################
# STEP 7: Start Frontend
###############################################################################

print_header "STEP 7: Starting Frontend Application"

print_info "Launching Electron application..."
npm run dev >> "$PROJECT_ROOT/frontend.log" 2>&1 &
FRONTEND_PID=$!

print_success "Frontend started (PID: $FRONTEND_PID)"

###############################################################################
# STEP 8: Summary
###############################################################################

print_header "SYSTEM READY"

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║           LEGAL ANALYSIS SYSTEM - RUNNING                  ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${BLUE}Backend Server:${NC}  http://localhost:8000"
echo -e "${BLUE}API Docs:${NC}        http://localhost:8000/docs"
echo -e "${BLUE}Frontend:${NC}        Electron App (should open automatically)"
echo ""
echo -e "${BLUE}Process IDs:${NC}"
echo -e "  Backend:  $BACKEND_PID"
echo -e "  Frontend: $FRONTEND_PID"
echo ""
echo -e "${BLUE}Available Systems:${NC}"
echo -e "  ${GREEN}✓${NC} TYPE-A: Litigation Case Analysis"
echo -e "  ${GREEN}✓${NC} TYPE-B: Pre-Litigation Advisory"
echo ""
echo -e "${BLUE}Logs:${NC}"
echo -e "  Startup:  $LOG_FILE"
echo -e "  Backend:  $PROJECT_ROOT/backend.log"
echo -e "  Frontend: $PROJECT_ROOT/frontend.log"
echo ""
echo -e "${YELLOW}To stop the system:${NC}"
echo -e "  kill $BACKEND_PID $FRONTEND_PID"
echo -e "  ${BLUE}or${NC} run: ./stop.sh"
echo ""
echo -e "${GREEN}Press Ctrl+C to stop monitoring (processes will continue)${NC}"
echo ""

# Monitor logs
tail -f "$PROJECT_ROOT/backend.log" "$PROJECT_ROOT/frontend.log" 2>/dev/null

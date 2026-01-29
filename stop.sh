#!/bin/bash

###############################################################################
# AI-Based Legal Case Classification & Analysis System
# Stop Script
# 
# This script will stop all running backend and frontend processes
###############################################################################

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

echo -e "${YELLOW}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${YELLOW}║  Stopping Legal Analysis System...                        ║${NC}"
echo -e "${YELLOW}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Stop backend (port 8000)
if lsof -i:8000 >/dev/null 2>&1; then
    print_info "Stopping backend server (port 8000)..."
    lsof -ti:8000 | xargs kill -9 2>/dev/null
    print_success "Backend stopped"
else
    print_info "Backend not running"
fi

# Stop any Python processes running main.py
PYTHON_PIDS=$(pgrep -f "python.*main.py")
if [ -n "$PYTHON_PIDS" ]; then
    print_info "Stopping Python backend processes..."
    echo "$PYTHON_PIDS" | xargs kill -9 2>/dev/null
    print_success "Python processes stopped"
fi

# Stop Electron/Node processes
ELECTRON_PIDS=$(pgrep -f "electron")
if [ -n "$ELECTRON_PIDS" ]; then
    print_info "Stopping Electron frontend..."
    echo "$ELECTRON_PIDS" | xargs kill -9 2>/dev/null
    print_success "Frontend stopped"
fi

# Stop npm dev processes
NPM_PIDS=$(pgrep -f "npm run dev")
if [ -n "$NPM_PIDS" ]; then
    print_info "Stopping npm processes..."
    echo "$NPM_PIDS" | xargs kill -9 2>/dev/null
    print_success "npm processes stopped"
fi

echo ""
print_success "All processes stopped"
echo ""

# Deployment Guide

## Prerequisites

### System Requirements
- **OS**: macOS, Linux, or Windows
- **Python**: 3.8 or higher
- **Node.js**: 16.x or higher
- **npm**: 8.x or higher
- **Tesseract OCR**: Latest version

### External Services
- **Google Gemini API**: API key required
  - Get from: https://makersuite.google.com/app/apikey

---

## Backend Deployment

### 1. Install System Dependencies

#### macOS
```bash
brew install tesseract
brew install python@3.11
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt-get update
sudo apt-get install tesseract-ocr
sudo apt-get install python3-pip python3-venv
```

### 2. Setup Python Environment

```bash
cd server

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # macOS/Linux
# OR
venv\Scripts\activate     # Windows

# Install dependencies
pip install -r requirements.txt

# Download spaCy model
python -m spacy download en_core_web_sm
```

### 3. Configure Environment Variables

```bash
# Create .env file
cp .env.example .env

# Edit .env and add your API key
nano .env
```

**.env file:**
```
GEMINI_API_KEY=your_api_key_here
```

### 4. Prepare Data and Models

```bash
# Ensure directories exist
mkdir -p models
mkdir -p data
mkdir -p documents

# Verify sections.json exists
ls data/sections.json
```

### 5. Run Backend Server

```bash
# Development
python main.py

# Production (with uvicorn)
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 4
```

**Verify:**
```bash
curl http://localhost:8000/
# Should return: {"message": "Legal Case Analysis API"}
```

---

## Frontend Deployment

### 1. Install Dependencies

```bash
cd client

# Install npm packages
npm install
```

### 2. Development Mode

```bash
# Run with hot reload
npm run electron:dev
```

This will:
1. Start Vite dev server on port 5173
2. Launch Electron window
3. Enable hot module replacement

### 3. Production Build

```bash
# Build React app
npm run build

# Run Electron with built app
npm run electron
```

### 4. Package Application (Optional)

```bash
# Install electron-builder globally
npm install -g electron-builder

# Package for current platform
npm run package

# Output in dist/ folder
```

---

## Production Deployment

### Backend (Server)

#### Option 1: systemd Service (Linux)

Create `/etc/systemd/system/legal-analysis.service`:

```ini
[Unit]
Description=Legal Case Analysis API
After=network.target

[Service]
Type=simple
User=your_user
WorkingDirectory=/path/to/server
Environment="PATH=/path/to/server/venv/bin"
ExecStart=/path/to/server/venv/bin/uvicorn main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
```

Enable and start:
```bash
sudo systemctl enable legal-analysis
sudo systemctl start legal-analysis
sudo systemctl status legal-analysis
```

#### Option 2: Docker

**Dockerfile:**
```dockerfile
FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN python -m spacy download en_core_web_sm

# Copy application
COPY . .

# Expose port
EXPOSE 8000

# Run application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**Build and run:**
```bash
docker build -t legal-analysis-api .
docker run -d -p 8000:8000 --env-file .env legal-analysis-api
```

#### Option 3: Cloud Deployment (AWS/GCP/Azure)

1. **Set up VM instance**
2. **Install dependencies**
3. **Clone repository**
4. **Configure environment**
5. **Set up reverse proxy (nginx)**
6. **Enable HTTPS (Let's Encrypt)**
7. **Configure firewall**

---

## Nginx Reverse Proxy (Optional)

**/etc/nginx/sites-available/legal-analysis:**

```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

Enable and restart:
```bash
sudo ln -s /etc/nginx/sites-available/legal-analysis /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

---

## Security Considerations

### 1. Environment Variables
- Never commit `.env` to version control
- Use secrets management in production
- Rotate API keys regularly

### 2. CORS Configuration
Update `main.py`:
```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://your-domain.com"],  # Specific origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### 3. File Upload Security
- Implement file size limits
- Validate file types
- Scan for malware
- Store uploads securely

### 4. API Rate Limiting
Install and configure:
```bash
pip install slowapi
```

### 5. HTTPS
- Use Let's Encrypt for SSL certificates
- Force HTTPS redirects
- Enable HSTS headers

---

## Monitoring

### Logging
Logs are written to stdout. Configure log aggregation:

```bash
# View logs
tail -f /var/log/legal-analysis.log

# With systemd
journalctl -u legal-analysis -f
```

### Health Checks
Create health check endpoint:
```python
@app.get("/health")
async def health_check():
    return {"status": "healthy"}
```

### Metrics
Consider adding:
- Prometheus metrics
- Request counters
- Response time tracking
- Error rates

---

## Backup

### Database (if added)
```bash
# Backup
pg_dump legal_analysis > backup.sql

# Restore
psql legal_analysis < backup.sql
```

### Documents
```bash
# Backup generated reports
tar -czf documents-backup.tar.gz documents/

# Restore
tar -xzf documents-backup.tar.gz
```

---

## Troubleshooting

### Backend won't start
```bash
# Check Python version
python --version

# Check dependencies
pip list

# Check Tesseract
tesseract --version

# Check logs
python main.py
```

### Frontend won't connect
```bash
# Check backend is running
curl http://localhost:8000/

# Check CORS settings
# Check network/firewall
```

### PDF generation fails
```bash
# Check ReportLab installation
pip show reportlab

# Check write permissions
ls -la documents/
```

### OCR not working
```bash
# Check Tesseract installation
which tesseract
tesseract --version

# Check language data
tesseract --list-langs
```

---

## Scaling

### Horizontal Scaling
- Deploy multiple backend instances
- Use load balancer (nginx, HAProxy)
- Share document storage (NFS, S3)

### Vertical Scaling
- Increase worker count
- Optimize model loading
- Add caching (Redis)

### Database
- Add PostgreSQL for case history
- Implement connection pooling
- Set up read replicas

---

## Maintenance

### Updates
```bash
# Backend
cd server
source venv/bin/activate
pip install --upgrade -r requirements.txt

# Frontend
cd client
npm update
```

### Cleanup
```bash
# Remove old reports (older than 30 days)
find documents/ -type f -mtime +30 -delete

# Clear logs
truncate -s 0 /var/log/legal-analysis.log
```

---

## Support

For issues and questions:
- Check logs first
- Review documentation
- Test with sample cases
- Verify API key validity

# Quick Start Guide

## One-Click Startup

### Prerequisites
- Python 3.8+ installed
- Node.js 16+ installed
- GEMINI_API_KEY configured in `mcp/server/.env`

### Start the System

Simply run:

```bash
./start.sh
```

This will automatically:
1. ✅ Check Python and Node.js environment
2. ✅ Install/verify dependencies
3. ✅ Load knowledge base for TYPE-B (Advisory)
4. ✅ Start backend server (http://localhost:8000)
5. ✅ Start frontend Electron app
6. ✅ Verify both TYPE-A and TYPE-B are ready

### Stop the System

```bash
./stop.sh
```

This will cleanly stop all backend and frontend processes.

---

## Manual Startup (Alternative)

### Backend

```bash
cd mcp/server
source venv/bin/activate
python load_knowledge_base.py  # First time only
python main.py
```

### Frontend

```bash
cd mcp/client
npm install  # First time only
npm run dev
```

---

## System Features

### TYPE-A: Litigation Case Analysis
- Upload FIR documents
- Automatic issue classification
- Legal section mapping
- Evidence extraction
- AI-powered legal analysis
- PDF report generation

### TYPE-B: Pre-Litigation Advisory
- Property law guidance
- Business compliance advisory
- Immigration consultation
- Contract review
- Employment law advice
- Family law guidance
- Tax compliance

---

## API Endpoints

### Backend Server
- **Health Check**: `GET http://localhost:8000/health`
- **API Docs**: `http://localhost:8000/docs`
- **Litigation Analysis**: `POST /analyze-case`
- **Advisory Analysis**: `POST /analyze-advisory`

---

## Troubleshooting

### Backend won't start
- Check if port 8000 is available: `lsof -i:8000`
- Check `.env` file exists with `GEMINI_API_KEY`
- Check logs: `tail -f backend.log`

### Frontend won't start
- Ensure `node_modules` installed: `cd mcp/client && npm install`
- Check logs: `tail -f frontend.log`

### Knowledge base not loading
- Check `mcp/server/data/advisory_knowledge/` exists
- Run manually: `cd mcp/server && python load_knowledge_base.py`

---

## Logs

- **Startup Log**: `startup.log`
- **Backend Log**: `backend.log`
- **Frontend Log**: `frontend.log`

---

## Support

For issues, check:
1. Log files (above)
2. `PROJECT_DOCUMENTATION/` folder
3. API documentation at http://localhost:8000/docs

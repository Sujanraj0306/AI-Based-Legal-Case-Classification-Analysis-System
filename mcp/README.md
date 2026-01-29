# AI-Based Legal Case Classification & Analysis System

## Overview
This is a local-first AI system that accepts case statements, FIR text/images, and supporting documents, classifies legal issues, maps applicable legal sections, and generates structured Case Analysis Reports.

## Project Structure

```
mcp/
├── client/                 # Electron + React frontend (to be implemented)
└── server/                 # Python FastAPI backend
    ├── tools/              # MCP modular tools
    ├── models/             # Data models and schemas
    ├── data/               # ChromaDB and runtime data
    ├── main.py             # FastAPI server entry point
    ├── requirements.txt    # Python dependencies
    └── venv/               # Python virtual environment
```

## Technology Stack

### Backend
- **Python 3.x** with FastAPI
- **AI Models**: HuggingFace law-ai models, Gemini API
- **Vector Database**: ChromaDB
- **OCR & Document Processing**: Tesseract, PyMuPDF, python-docx

### Frontend (To be implemented)
- **Electron** for desktop application
- **React** for UI components
- **Tailwind CSS** for styling

## Setup Instructions

### 1. Activate Virtual Environment

```bash
cd mcp/server
source venv/bin/activate  # On macOS/Linux
# or
venv\Scripts\activate  # On Windows
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Run the Server

```bash
python main.py
```

The server will start on `http://localhost:8000`

### 4. Verify Installation

Visit `http://localhost:8000/health` - should return `{"status": "ok"}`

Visit `http://localhost:8000/docs` - for interactive API documentation

## API Endpoints

### Health Check
- **GET** `/health`
- Returns: `{"status": "ok"}`

### Root
- **GET** `/`
- Returns API information

## MCP Tools (To be implemented)

1. **parser_tool** - OCR, language detection, translation, text cleaning
2. **issue_classifier_tool** - Domain and issue classification
3. **section_mapper_tool** - Legal section mapping
4. **rag_tool** - Retrieve statutes and case law
5. **evidence_extractor_tool** - Extract witnesses and documents
6. **legal_analyzer_tool** - Apply law to facts
7. **report_generator_tool** - Generate structured reports

## Target Users
- Advocates
- Law Students
- Legal Researchers
- Legal Aid Clinics
- Legal-Tech Startups

## Success Metrics
- Issue classification accuracy ≥ 85%
- Section mapping precision ≥ 80%
- Report generation < 10 seconds
- Zero data loss

## Development Status
✅ Project structure created
✅ Virtual environment setup
✅ FastAPI server bootstrapped
✅ Health check endpoint working
⏳ MCP tools implementation pending
⏳ Frontend implementation pending

## References
- PRD: See `PRD.md`
- Design Document: See `Design_Document.md`
- Tech Stack: See `Tech_Stack.md`

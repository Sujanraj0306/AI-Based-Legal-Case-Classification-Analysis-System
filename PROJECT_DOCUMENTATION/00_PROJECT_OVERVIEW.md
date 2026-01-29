# AI-Based Legal Case Classification & Analysis System

## Project Overview

This is a comprehensive legal case analysis system that combines machine learning, natural language processing, and AI-powered analysis to assist legal professionals in case classification, evidence extraction, and legal reasoning.

## System Architecture

### Backend (Python/FastAPI)
- **Framework**: FastAPI with async support
- **ML Models**: Sentence transformers, ChromaDB for vector search
- **AI Integration**: Google Gemini API for legal analysis
- **Document Processing**: OCR (Tesseract), PDF/DOCX parsing
- **NLP**: spaCy for entity extraction

### Frontend (Electron + React)
- **Framework**: Electron for desktop application
- **UI**: React with Vite
- **Styling**: Custom CSS with "Law Firm" black-and-white theme
- **Communication**: Axios for API calls

## Key Features

1. **Document Upload & Processing**
   - Support for text input and file uploads (PDF, DOCX, images)
   - OCR for scanned documents
   - Multi-language support with translation

2. **Legal Classification**
   - Domain classification (Criminal, Civil, Family, etc.)
   - Issue identification with confidence scores
   - Multi-label classification support

3. **Section Mapping**
   - Automatic mapping to relevant legal sections (IPC, IT Act, CrPC, BNS)
   - Detailed section information with punishments and classifications

4. **Evidence Extraction**
   - Witness identification
   - Document references
   - Date and location extraction
   - Monetary amount detection

5. **AI Legal Analysis**
   - Gemini-powered legal reasoning
   - Application of law to facts
   - Structured analysis with tables

6. **Report Generation**
   - Professional PDF reports with tables
   - Markdown reports for editing
   - Formatted with legal document standards

## Technology Stack

### Backend Dependencies
- fastapi
- uvicorn
- transformers
- torch
- sentence-transformers
- chromadb
- pytesseract
- pillow
- python-docx
- pymupdf
- langdetect
- google-generativeai
- pydantic
- python-dotenv
- sentencepiece
- python-multipart
- spacy
- markdown2
- reportlab

### Frontend Dependencies
- react
- react-dom
- axios
- electron
- vite
- concurrently
- wait-on

## Project Structure

```
mcp/
├── server/
│   ├── main.py                 # FastAPI application
│   ├── orchestrator.py         # Workflow orchestration
│   ├── model_loader.py         # ML model management
│   ├── text_preprocessor.py    # Text processing & translation
│   ├── document_processor.py   # File handling & OCR
│   ├── tools/
│   │   ├── issue_classifier_tool.py
│   │   ├── section_mapper_tool.py
│   │   ├── evidence_extractor_tool.py
│   │   ├── legal_analyzer_tool.py
│   │   └── report_generator_tool.py
│   ├── models/                 # ML models storage
│   └── data/                   # Legal sections database
├── client/
│   ├── src/
│   │   ├── App.jsx
│   │   ├── components/
│   │   │   ├── CaseForm.jsx
│   │   │   ├── ProgressIndicator.jsx
│   │   │   └── ResultsView.jsx
│   │   ├── services/
│   │   │   └── api.js
│   │   └── styles/
│   │       └── App.css
│   ├── electron/
│   │   ├── main.js
│   │   └── preload.js
│   └── package.json
└── documents/                  # Generated reports

```

## Development Timeline

The project was developed in 13+ phases, each focusing on specific functionality:

1. **Phase 1-2**: Initial setup and basic classification
2. **Phase 3-4**: Section mapping and evidence extraction
3. **Phase 5-6**: Legal analysis integration
4. **Phase 7-8**: Report generation
5. **Phase 9-10**: Electron UI development
6. **Phase 11**: Orchestrator for workflow automation
7. **Phase 12**: Production hardening
8. **Phase 13**: UI refinements and formatting
9. **Additional**: Bug fixes, API updates, PDF enhancements

## Current Status

✅ Fully functional legal case analysis system
✅ Desktop application with professional UI
✅ AI-powered analysis with Gemini
✅ Comprehensive PDF report generation
✅ Production-ready with logging and error handling

## Future Enhancements

- Multi-user support with authentication
- Case history and database
- Advanced analytics and insights
- Integration with legal databases
- Mobile application
- Collaborative features

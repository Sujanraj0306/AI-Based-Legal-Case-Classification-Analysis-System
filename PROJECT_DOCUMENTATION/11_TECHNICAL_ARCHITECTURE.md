# Technical Architecture

## System Overview

The Legal Case Analysis System is a full-stack application combining machine learning, natural language processing, and AI-powered reasoning to automate legal case analysis.

## Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    ELECTRON DESKTOP APP                      │
│  ┌────────────┐  ┌──────────────┐  ┌──────────────────┐    │
│  │ CaseForm   │→ │ App.jsx      │→ │ ResultsView      │    │
│  │ (Input)    │  │ (Orchestrate)│  │ (Display)        │    │
│  └────────────┘  └──────────────┘  └──────────────────┘    │
│         │                │                    ↑              │
│         └────────────────┼────────────────────┘              │
│                          │ HTTP/REST                         │
└──────────────────────────┼───────────────────────────────────┘
                           │
                           ↓
┌─────────────────────────────────────────────────────────────┐
│                    FASTAPI BACKEND                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                    main.py                            │   │
│  │  - CORS Middleware                                    │   │
│  │  - Request Tracking                                   │   │
│  │  - Exception Handling                                 │   │
│  │  - Logging                                            │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│                          ↓                                   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              orchestrator.py                          │   │
│  │  - Workflow Coordination                              │   │
│  │  - Tool Integration                                   │   │
│  └──────────────────────────────────────────────────────┘   │
│                          │                                   │
│         ┌────────────────┼────────────────┐                 │
│         ↓                ↓                ↓                 │
│  ┌──────────┐    ┌──────────┐    ┌──────────────┐          │
│  │Document  │    │  Text    │    │ Model        │          │
│  │Processor │    │Preproc.  │    │ Loader       │          │
│  └──────────┘    └──────────┘    └──────────────┘          │
│                                                              │
│  ┌──────────────────────────────────────────────────────┐   │
│  │                    TOOLS                              │   │
│  │  ┌────────────────┐  ┌────────────────┐              │   │
│  │  │ Issue          │  │ Section        │              │   │
│  │  │ Classifier     │  │ Mapper         │              │   │
│  │  └────────────────┘  └────────────────┘              │   │
│  │  ┌────────────────┐  ┌────────────────┐              │   │
│  │  │ Evidence       │  │ Legal          │              │   │
│  │  │ Extractor      │  │ Analyzer       │              │   │
│  │  └────────────────┘  └────────────────┘              │   │
│  │  ┌────────────────┐                                   │   │
│  │  │ Report         │                                   │   │
│  │  │ Generator      │                                   │   │
│  │  └────────────────┘                                   │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         ↓                 ↓                 ↓
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│ ChromaDB     │  │ Google       │  │ spaCy        │
│ (Vectors)    │  │ Gemini API   │  │ (NER)        │
└──────────────┘  └──────────────┘  └──────────────┘
```

## Component Details

### Frontend Layer

#### Electron Main Process
- **File**: `electron/main.js`
- **Responsibilities**:
  - Create and manage application window
  - Handle IPC communication
  - Provide file system access (PDF/folder opening)
  - Development/production mode switching

#### React Application
- **Framework**: React 18 with Vite
- **State Management**: React hooks (useState, useEffect)
- **Components**:
  - `App.jsx`: Main orchestrator
  - `CaseForm.jsx`: Input form
  - `ProgressIndicator.jsx`: Status display
  - `ResultsView.jsx`: Results with markdown parser

#### API Client
- **File**: `services/api.js`
- **Library**: Axios
- **Features**:
  - Centralized API calls
  - Error handling
  - File upload support
  - Response parsing

### Backend Layer

#### Web Framework
- **FastAPI**: Async Python web framework
- **Features**:
  - Automatic OpenAPI documentation
  - Request validation with Pydantic
  - Async/await support
  - High performance

#### Middleware Stack
1. **CORS Middleware**: Cross-origin requests
2. **Request Tracking**: UUID and timing
3. **Exception Handler**: Global error catching
4. **Logging Filter**: Request ID injection

#### Core Services

##### Document Processor
- **PDF**: PyMuPDF (fitz)
- **DOCX**: python-docx
- **OCR**: Tesseract via pytesseract
- **Images**: Pillow (PIL)

##### Text Preprocessor
- **Cleaning**: Regex-based normalization
- **Language Detection**: langdetect
- **Translation**: Google Gemini API
- **Supported Languages**: 10+ Indian languages

##### Model Loader
- **Purpose**: Centralized model management
- **Caching**: In-memory model cache
- **Models**:
  - Sentence transformers
  - spaCy NER models

### Tool Layer

#### Issue Classifier
- **Model**: sentence-transformers/all-MiniLM-L6-v2
- **Vector DB**: ChromaDB
- **Method**: Semantic similarity search
- **Output**: Domain + issues with confidence

#### Section Mapper
- **Database**: JSON file with 100+ sections
- **Search**: Vector similarity
- **Acts**: IPC, IT Act, CrPC, BNS
- **Metadata**: Punishment, bailable, cognizable

#### Evidence Extractor
- **NER**: spaCy en_core_web_sm
- **Entities**: PERSON, DATE, GPE, LOC, MONEY
- **Patterns**: Regex for documents
- **Output**: Structured evidence JSON

#### Legal Analyzer
- **AI**: Google Gemini Flash
- **Prompt Engineering**: Structured legal prompts
- **Output**: Markdown with tables
- **Fallback**: Template-based analysis

#### Report Generator
- **Markdown**: markdown2 library
- **PDF**: ReportLab
- **Parsing**: Custom markdown parser
- **Styling**: Professional legal document format

### Data Layer

#### Vector Database
- **ChromaDB**: Embeddings storage
- **Collections**:
  - Legal domains
  - Legal sections
- **Persistence**: Local disk

#### File Storage
- **Documents**: `documents/{case_id}/`
- **Models**: `models/`
- **Data**: `data/sections.json`

#### External APIs
- **Google Gemini**: Legal analysis and translation
- **Rate Limiting**: API quota management
- **Error Handling**: Fallback mechanisms

## Data Flow

### Complete Analysis Pipeline

```
1. User Input
   ↓
2. File Upload → Document Processor
   ↓
3. Text Extraction → OCR if needed
   ↓
4. Text Preprocessing → Clean + Translate
   ↓
5. Issue Classification → Vector search
   ↓
6. Section Mapping → Vector search + filtering
   ↓
7. Evidence Extraction → NER + patterns
   ↓
8. Legal Analysis → Gemini API
   ↓
9. Report Generation → Markdown + PDF
   ↓
10. Results Display → UI rendering
```

### Request Flow

```
Client Request
    ↓
FastAPI Endpoint
    ↓
Request Middleware (ID, timing)
    ↓
Orchestrator
    ↓
Tool Execution (sequential)
    ↓
Response Middleware (headers)
    ↓
Client Response
```

## Technology Stack

### Backend
- **Language**: Python 3.11
- **Framework**: FastAPI 0.104+
- **ML**: transformers, sentence-transformers, torch
- **NLP**: spaCy 3.7+
- **Vector DB**: ChromaDB 0.4+
- **AI**: google-generativeai
- **Document**: PyMuPDF, python-docx, pytesseract
- **PDF**: ReportLab
- **Utils**: pydantic, python-dotenv, langdetect

### Frontend
- **Runtime**: Electron 28+
- **Framework**: React 18
- **Build**: Vite 5
- **HTTP**: Axios
- **Styling**: Vanilla CSS

### Infrastructure
- **OS**: Cross-platform (macOS, Linux, Windows)
- **OCR**: Tesseract 5+
- **Python**: 3.8-3.11
- **Node.js**: 16+

## Design Patterns

### Backend Patterns

#### Singleton Pattern
- Model Loader: Single instance for model caching
- Report Generator: Global instance

#### Factory Pattern
- Tool creation based on configuration
- Model loading based on type

#### Strategy Pattern
- Different document processors for different formats
- Multiple translation strategies

#### Observer Pattern
- Request tracking middleware
- Logging system

### Frontend Patterns

#### Component Pattern
- Reusable UI components
- Props-based communication

#### Container/Presentational
- App.jsx: Container (logic)
- Components: Presentational (UI)

#### Service Pattern
- API service abstraction
- Centralized HTTP calls

## Security Architecture

### API Security
- Environment variable for API keys
- No hardcoded credentials
- CORS configuration
- Request validation

### File Security
- File type validation
- Size limits
- Secure file storage
- Path sanitization

### Data Privacy
- Local processing where possible
- API calls only for AI features
- No persistent user data
- Case ID anonymization

## Performance Optimization

### Backend
- Model caching (avoid reloading)
- Async operations
- Efficient vector search
- Batch processing where possible

### Frontend
- Lazy loading
- Component memoization
- Efficient re-renders
- Optimized bundle size

### Database
- Vector indexing
- In-memory caching
- Efficient similarity search

## Scalability Considerations

### Horizontal Scaling
- Stateless API design
- Shared file storage (NFS/S3)
- Load balancing ready

### Vertical Scaling
- Multi-worker support
- Async processing
- Resource optimization

### Future Enhancements
- Database for case history
- Caching layer (Redis)
- Message queue for async tasks
- Microservices architecture

## Error Handling

### Levels
1. **Tool Level**: Try-catch in each tool
2. **Orchestrator Level**: Step-by-step error handling
3. **API Level**: Global exception handler
4. **Client Level**: User-friendly error messages

### Logging
- Structured logging with request IDs
- Different log levels (INFO, WARNING, ERROR)
- Contextual information
- Performance metrics

## Testing Strategy

### Backend
- Unit tests for each tool
- Integration tests for orchestrator
- API endpoint tests
- Performance tests

### Frontend
- Component tests
- Integration tests
- E2E tests with Electron

### Manual Testing
- Sample case library
- Edge case scenarios
- Multi-language testing
- Performance benchmarking

## Deployment Architecture

### Development
```
Backend: localhost:8000
Frontend: Electron + Vite dev server
```

### Production
```
Backend: Uvicorn with multiple workers
Frontend: Packaged Electron app
Reverse Proxy: Nginx (optional)
SSL: Let's Encrypt (if web-accessible)
```

## Monitoring and Observability

### Metrics
- Request count
- Response times
- Error rates
- API usage

### Logging
- Application logs
- Access logs
- Error logs
- Performance logs

### Health Checks
- API health endpoint
- Model availability
- External service status

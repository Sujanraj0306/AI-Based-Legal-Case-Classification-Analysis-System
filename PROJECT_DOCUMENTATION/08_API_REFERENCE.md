# API Reference

## Base URL
```
http://localhost:8000
```

## Authentication
Currently no authentication required (development mode).

## Endpoints

### 1. Upload Files
**POST** `/upload`

Upload case documents and extract text.

**Request:**
- Content-Type: `multipart/form-data`
- Body:
  - `files`: File[] (PDF, DOCX, images)
  - `statement_text`: string (optional)
  - `fir_text`: string (optional)
  - `additional_evidence_text`: string (optional)

**Response:**
```json
{
  "case_id": "CASE_20240128_123456",
  "statement_text": "Combined text from input and files",
  "fir_text": "Combined FIR text",
  "additional_evidence": "Additional evidence text",
  "files_processed": 2
}
```

---

### 2. Preprocess Text
**POST** `/preprocess`

Clean and translate text to English.

**Request:**
```json
{
  "text": "Text to preprocess"
}
```

**Response:**
```json
{
  "original_text": "Original text",
  "cleaned_text": "Cleaned text",
  "detected_language": "hi",
  "translated_text": "Translated to English",
  "preprocessing_applied": true
}
```

---

### 3. Classify Issue
**POST** `/classify`

Classify legal domain and issues.

**Request:**
```json
{
  "text": "Case facts text"
}
```

**Response:**
```json
{
  "domain": "Criminal",
  "domain_confidence": 0.95,
  "primary_issue": "Fraud",
  "secondary_issues": ["Cheating", "Criminal Breach of Trust"],
  "all_predictions": [
    {
      "label": "Criminal",
      "confidence": 0.95
    }
  ]
}
```

---

### 4. Map Sections
**POST** `/map-sections`

Map to applicable legal sections.

**Request:**
```json
{
  "text": "Case facts",
  "domain": "Criminal",
  "primary_issue": "Fraud"
}
```

**Response:**
```json
{
  "sections": [
    {
      "act": "IPC",
      "section": "420",
      "title": "Cheating and dishonestly inducing delivery of property",
      "description": "Whoever cheats...",
      "punishment": "Imprisonment up to 7 years and fine",
      "bailable": false,
      "cognizable": true,
      "confidence": 0.92
    }
  ],
  "total_sections": 3
}
```

---

### 5. Extract Evidence
**POST** `/extract-evidence`

Extract evidence from case text.

**Request:**
```json
{
  "text": "Case facts with evidence"
}
```

**Response:**
```json
{
  "witnesses": [
    {
      "name": "John Doe",
      "is_witness": true,
      "type": "witness",
      "context": "John Doe testified..."
    }
  ],
  "documents": [
    {
      "reference": "CCTV footage",
      "context": "CCTV footage shows..."
    }
  ],
  "dates": [
    {
      "date": "15/01/2024",
      "context": "Incident occurred on..."
    }
  ],
  "locations": [
    {
      "location": "Mumbai",
      "context": "Crime scene in Mumbai"
    }
  ],
  "money": [
    {
      "amount": "₹75,000",
      "context": "Amount debited..."
    }
  ],
  "summary": {
    "confirmed_witnesses": 1,
    "total_documents": 1,
    "total_dates": 1,
    "total_locations": 1
  }
}
```

---

### 6. Legal Analysis
**POST** `/legal-analysis`

Generate AI-powered legal analysis.

**Request:**
```json
{
  "facts": "Case facts",
  "sections": [...],
  "domain": "Criminal",
  "evidence": {...}
}
```

**Response:**
```json
{
  "analysis": "Markdown formatted legal analysis with tables and reasoning",
  "generated_at": "2024-01-28T12:00:00",
  "model_used": "gemini-flash-latest"
}
```

---

### 7. Generate Report
**POST** `/generate-report`

Generate PDF and Markdown reports.

**Request:**
```json
{
  "case_id": "CASE_20240128_123456",
  "case_data": {
    "facts": "...",
    "domain": "...",
    "primary_issue": "...",
    "sections": [...],
    "evidence": {...},
    "analysis": "..."
  },
  "save_markdown": true
}
```

**Response:**
```json
{
  "case_id": "CASE_20240128_123456",
  "pdf_path": "/path/to/case_analysis_report.pdf",
  "markdown_path": "/path/to/case_analysis_report.md",
  "case_directory": "/path/to/case_directory",
  "generated_at": "2024-01-28T12:00:00",
  "report_size_kb": 125.5
}
```

---

### 8. Analyze Case (Orchestrated)
**POST** `/analyze-case`

Complete analysis pipeline in one call.

**Request:**
- Content-Type: `multipart/form-data`
- Body:
  - `files`: File[]
  - `title`: string

**Response:**
```json
{
  "case_id": "...",
  "classification": {...},
  "sections": [...],
  "evidence": {...},
  "analysis": "...",
  "report": {...},
  "processing_time": 25.3
}
```

---

## Error Responses

All endpoints return errors in this format:

```json
{
  "error": "Error type",
  "detail": "Detailed error message",
  "request_id": "uuid",
  "timestamp": "ISO timestamp"
}
```

**Status Codes:**
- `200` - Success
- `400` - Bad Request
- `422` - Validation Error
- `500` - Internal Server Error

---

## Headers

### Request Headers
- `Content-Type`: `application/json` or `multipart/form-data`

### Response Headers
- `X-Request-ID`: Unique request identifier
- `X-Process-Time`: Processing time in seconds

---

## Rate Limiting
Currently no rate limiting (development mode).

## CORS
All origins allowed (development mode).

**Production**: Configure specific origins in `main.py`

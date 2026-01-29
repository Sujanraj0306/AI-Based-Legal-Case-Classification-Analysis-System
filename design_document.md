# Design Document

## 1. Overview
This document describes the system architecture, user experience, data flow, and internal tool design for the AI-Based Legal Case Classification & Analysis System.

---

## 2. High-Level Architecture

Electron UI
  |
  | MCP
  |
AI Orchestrator Server
  |
--------------------------------------------------
| Parser Tool | Issue Classifier | Section Mapper |
| Evidence Tool | RAG Tool | Legal Analyzer |
| Report Generator |
--------------------------------------------------

---

## 3. User Interface Layout

CASE TITLE (Heading Input)

STATEMENT
- Large multiline text area
- Upload file

FIR DETAILS
- Multiline text area
- Upload image or file

OTHER DOCUMENTS
- Multiple file upload

ANALYZE CASE button

---

## 4. Data Flow

User Input
→ OCR & Parsing
→ Embedding & Storage (ChromaDB)
→ Issue Classification
→ Section Mapping
→ Evidence Extraction
→ Legal Analysis
→ Report Generation
→ Save to Local Storage

---

## 5. MCP Tool Definitions

### parser_tool
- OCR
- Language detection
- Translation
- Text cleaning

### issue_classifier_tool
- Domain classification
- Primary and secondary issue detection

### section_mapper_tool
- Act and section mapping

### rag_tool
- Retrieve statutes and case law

### evidence_extractor_tool
- Witness and document extraction

### legal_analyzer_tool
- Apply law to facts

### report_generator_tool
- Generate structured report

---

## 6. RAG Design

ChromaDB Collections:
- statutes
- judgments
- embeddings
- reports

---

## 7. Storage Structure

root/
 └── documents/
      └── case_id/
           ├── statement.txt
           ├── fir.txt
           ├── uploads/
           └── case_analysis_report.pdf

---

## 8. Error Handling
- Fallback model usage
- Input validation
- Logging


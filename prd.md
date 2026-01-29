# Product Requirements Document (PRD)

## 1. Product Title
AI-Based Legal Case Classification & Analysis System

---

## 2. Purpose
Build a local-first AI system that accepts case statements, FIR text/images, and supporting documents, classifies legal issues, maps applicable legal sections, and generates a structured **Case Analysis Report** for faster and reliable legal review.

---

## 3. Target Users
- Advocates
- Law Students
- Legal Researchers
- Legal Aid Clinics
- Legal-Tech Startups

---

## 4. Objectives
- Convert unstructured legal inputs into structured case data
- Automatically identify legal issues
- Map issues to relevant statutes and sections
- Generate explainable legal reasoning
- Store all cases and reports locally

---

## 5. Functional Requirements

### 5.1 Case Intake Interface

The UI must resemble a **case intake form**, not a chat interface.

#### Case Title
Large heading text input

#### Statement Section
- Multiline text area
- Upload file option (PDF, DOCX, TXT, Image)

#### FIR Details
- Multiline text area
- Upload image or document

#### Other Documents
- Multiple file upload

#### Action
- Analyze Case button

---

### 5.2 Input Processing
- OCR for images
- Language detection
- Translation to English
- Text normalization

---

### 5.3 Case Analysis Capabilities
- Problem identification
- Issue classification
- Section mapping
- Evidence extraction
- Legal reasoning
- Report generation

---

### 5.4 Case Analysis Report
System must generate and save report to:

/root/documents/{case_id}/case_analysis_report.pdf

---

## 6. Non-Functional Requirements
- Works on Windows and macOS
- Local-first execution
- Modular MCP tools
- Explainable outputs
- Fast inference

---

## 7. Success Metrics
- Issue classification accuracy ≥ 85%
- Section mapping precision ≥ 80%
- Report generation < 10 seconds
- Zero data loss


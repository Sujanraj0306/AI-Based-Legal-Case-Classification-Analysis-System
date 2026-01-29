# User Guide

## Getting Started

### Installation

1. **Install Backend**
   ```bash
   cd server
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   python -m spacy download en_core_web_sm
   ```

2. **Configure API Key**
   ```bash
   cp .env.example .env
   # Edit .env and add your GEMINI_API_KEY
   ```

3. **Start Backend**
   ```bash
   python main.py
   ```

4. **Install Frontend**
   ```bash
   cd client
   npm install
   ```

5. **Start Application**
   ```bash
   npm run electron:dev
   ```

---

## Using the Application

### Step 1: Enter Case Details

The application opens with a case input form.

#### Statement of Facts
- **Text Input**: Type or paste the case statement directly
- **File Upload**: Upload PDF, DOCX, or image files
- **Both**: You can provide both text and files

**Supported Formats:**
- PDF documents
- Word documents (.docx)
- Images (PNG, JPG) - will be OCR processed

#### FIR Details
- Similar to Statement of Facts
- Provide FIR text or upload FIR document
- Optional field

#### Additional Evidence
- Upload supporting documents
- Multiple files supported
- Optional field

### Step 2: Submit for Analysis

Click **"ANALYZE CASE"** button.

The system will:
1. Process uploaded files
2. Extract and clean text
3. Translate if needed (Hindi, Tamil, etc. → English)
4. Classify the legal domain and issues
5. Map to applicable legal sections
6. Extract evidence
7. Generate AI-powered legal analysis
8. Create PDF report

**Processing Time:** 15-30 seconds typically

### Step 3: View Results

Results are displayed in sections:

#### Legal Classification
- **Domain**: Criminal, Civil, Family, etc.
- **Primary Issue**: Main legal issue identified
- **Secondary Issues**: Related issues
- **Confidence Score**: AI confidence percentage

#### Applicable Sections
- List of relevant legal sections
- Act name (IPC, IT Act, CrPC, BNS)
- Section number and title
- Bailable/Cognizable status
- Punishment details

#### Evidence Summary
- **Witnesses**: Identified persons
- **Documents**: Referenced documents
- **Dates**: Important dates found
- **Locations**: Places mentioned

#### Legal Analysis
- Comprehensive AI-generated analysis
- Application of law to facts
- Element-by-element breakdown
- Tables showing legal elements
- Reasoning and conclusions

#### Report Actions
- **OPEN REPORT (PDF)**: View generated PDF
- **OPEN DIRECTORY**: Open folder containing all case files
- **NEW CASE ANALYSIS**: Start a new analysis

---

## Understanding the Analysis

### Legal Classification

**Domain** indicates the area of law:
- Criminal Law
- Civil Law
- Family Law
- Constitutional Law
- Corporate Law
- Property Law
- Labor Law
- Tax Law
- Environmental Law
- Intellectual Property

**Confidence Score** shows how certain the AI is about the classification (0-100%).

### Legal Sections

Each section includes:
- **Act**: The legal act (e.g., IPC, IT Act)
- **Section Number**: Specific section
- **Title**: Section heading
- **Description**: What the section covers
- **Punishment**: Penalties prescribed
- **Bailable**: Whether bail can be granted
- **Cognizable**: Whether police can arrest without warrant

### Evidence Extraction

The system automatically identifies:
- **Witnesses**: People mentioned who may testify
- **Documents**: Referenced evidence (CCTV, receipts, etc.)
- **Dates**: Important dates in the case
- **Locations**: Places where events occurred
- **Money**: Monetary amounts involved

### AI Legal Analysis

The analysis includes:
1. **Case Summary**: Overview of the facts
2. **Elements Analysis**: Breaking down legal requirements
3. **Application to Facts**: How the law applies
4. **Evidence Correlation**: Linking evidence to elements
5. **Conclusions**: Legal findings
6. **Recommendations**: Suggested next steps

---

## Tips for Best Results

### Input Quality

1. **Clear Text**: Provide clear, complete case facts
2. **Relevant Details**: Include all important information
3. **Chronological Order**: Present events in sequence
4. **Specific Dates**: Include exact dates when possible
5. **Names and Places**: Mention all relevant persons and locations

### File Uploads

1. **Good Quality**: Use clear, readable documents
2. **Proper Orientation**: Ensure images are right-side up
3. **File Size**: Keep files under 10MB for best performance
4. **Multiple Files**: Upload all relevant documents together

### Language Support

The system supports:
- English (native)
- Hindi
- Tamil
- Telugu
- Bengali
- Marathi
- And other Indian languages

**Note**: Non-English text is automatically translated to English for analysis.

---

## Common Scenarios

### Criminal Case
1. Enter FIR details
2. Upload FIR document if available
3. Provide statement of facts
4. Upload any evidence (photos, documents)
5. Submit for analysis

**Output**: IPC sections, criminal procedure, evidence analysis

### Civil Dispute
1. Enter case facts in Statement field
2. Upload relevant contracts/agreements
3. Include dates and monetary amounts
4. Submit for analysis

**Output**: Civil law sections, contractual analysis, remedies

### Family Law Matter
1. Describe the family situation
2. Include relevant dates (marriage, separation, etc.)
3. Upload supporting documents
4. Submit for analysis

**Output**: Family law sections, applicable procedures

---

## Reading the PDF Report

The generated PDF includes:

### Header Section
- Case ID (unique identifier)
- Generation date and time
- Domain and primary issue

### Main Sections
1. **Case Facts**: Your input
2. **Legal Classification**: Domain and issues
3. **Applicable Legal Sections**: Detailed section info
4. **Evidence Summary**: Extracted evidence
5. **Legal Analysis**: AI-generated analysis
6. **Conclusion**: Summary and recommendations
7. **Disclaimer**: Important legal notice

### Tables
- Element analysis tables
- Evidence correlation tables
- Section comparison tables

### Formatting
- Professional black-and-white layout
- Justified text for readability
- Clear section headers
- Proper spacing

---

## Troubleshooting

### "Analysis Failed"
- Check internet connection (needed for AI)
- Verify backend is running
- Check file formats are supported
- Try with simpler input first

### "File Upload Error"
- Ensure file size is reasonable
- Check file format (PDF, DOCX, PNG, JPG)
- Try uploading one file at a time
- Verify file is not corrupted

### "Translation Error"
- Check if text is in supported language
- Try providing English text directly
- Verify API key is configured

### "No Sections Found"
- Provide more detailed case facts
- Include specific legal issues
- Mention relevant acts if known
- Try rephrasing the case description

### PDF Won't Open
- Check if PDF was generated (look in documents folder)
- Verify PDF reader is installed
- Try opening manually from file system
- Check file permissions

---

## Best Practices

### For Lawyers
1. Review AI analysis critically
2. Verify section applicability
3. Cross-reference with legal databases
4. Use as research starting point
5. Consult case law for precedents

### For Students
1. Use for learning legal reasoning
2. Study how sections apply to facts
3. Compare with textbook examples
4. Understand element-by-element analysis
5. Practice legal writing

### For Researchers
1. Analyze multiple similar cases
2. Compare classification results
3. Study evidence extraction patterns
4. Evaluate AI reasoning quality
5. Document findings

---

## Limitations

### What the System CAN Do
✅ Classify legal domains and issues  
✅ Map to relevant legal sections  
✅ Extract evidence from text  
✅ Generate legal analysis  
✅ Create professional reports  
✅ Handle multiple languages  

### What the System CANNOT Do
❌ Replace legal advice from qualified lawyers  
❌ Guarantee 100% accuracy  
❌ Predict case outcomes  
❌ Access external legal databases  
❌ File cases or legal documents  
❌ Provide real-time legal updates  

---

## Privacy and Data

### Data Storage
- Case files stored locally in `documents/` folder
- Each case has unique ID
- Files not shared externally (except API calls)

### API Usage
- Text sent to Google Gemini API for analysis
- Subject to Google's privacy policy
- No data stored by Google after processing

### Recommendations
- Don't include sensitive personal information
- Anonymize names if needed for privacy
- Delete old cases regularly
- Secure your computer and API key

---

## Getting Help

### Documentation
- Read all phase documentation
- Check API reference
- Review deployment guide

### Debugging
1. Check backend logs
2. Check browser console (F12)
3. Verify all services running
4. Test with sample cases

### Support
- Review error messages carefully
- Check system requirements
- Verify configuration
- Test components individually

---

## Disclaimer

This system is an AI-powered tool for legal research and analysis. It is **NOT** a substitute for professional legal advice. Always consult with a qualified lawyer for specific legal matters. The analysis provided is based on AI interpretation and may contain errors or omissions.

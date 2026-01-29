# Legal Case Analysis UI

Electron + React desktop application for AI-powered legal case analysis.

## Features

- 📝 **Case Input**: Text or file upload (PDF, images, DOCX)
- 🔍 **AI Analysis**: Automatic classification and legal reasoning
- ⚖️ **Section Mapping**: Maps to IPC, BNS, IT Act, CrPC sections
- 🔎 **Evidence Extraction**: Identifies witnesses, documents, dates
- 📄 **PDF Reports**: Generates comprehensive case analysis reports

## Prerequisites

- Node.js 16+
- Backend server running on http://localhost:8000

## Installation

```bash
npm install
```

## Development

```bash
# Start Vite dev server
npm run dev

# In another terminal, start Electron
npm run electron
```

Or run both concurrently:

```bash
npm run electron:dev
```

## Usage

1. **Fill the form:**
   - Enter case title
   - Choose text input or file upload mode
   - Provide statement and FIR details
   - Upload additional documents (optional)

2. **Click "Analyze Case":**
   - Watch the 7-step progress indicator
   - Wait for analysis to complete

3. **View Results:**
   - See classification, sections, evidence
   - Read legal analysis
   - Open generated PDF report

## Build

```bash
npm run build
npm run package
```

## Project Structure

```
client/
├── electron/           # Electron main process
│   ├── main.js        # Main process
│   └── preload.js     # Preload script
├── src/
│   ├── components/    # React components
│   │   ├── CaseForm.jsx
│   │   ├── ProgressIndicator.jsx
│   │   └── ResultsView.jsx
│   ├── services/      # API client
│   │   └── api.js
│   ├── styles/        # CSS
│   │   └── App.css
│   ├── App.jsx        # Main app component
│   └── main.jsx       # React entry point
├── index.html         # HTML template
├── vite.config.js     # Vite configuration
└── package.json       # Dependencies
```

## API Endpoints

The UI integrates with the following backend endpoints:

- `POST /upload` - Upload documents
- `POST /preprocess` - Preprocess text
- `POST /classify-issues` - Classify legal issues
- `POST /map-sections` - Map to legal sections
- `POST /extract-evidence` - Extract evidence
- `POST /legal-analysis` - Generate analysis
- `POST /generate-report` - Create PDF report

## Technologies

- **Electron** - Desktop application framework
- **React** - UI framework
- **Vite** - Build tool
- **Axios** - HTTP client

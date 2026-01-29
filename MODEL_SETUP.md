# Model Setup Instructions

## Overview
The AI-Based Legal Case Classification & Analysis System uses machine learning models that are **not included in this repository** due to their large size.

## Required Models

### 1. Sentence Transformer Model
- **Model**: `sentence-transformers/all-MiniLM-L6-v2`
- **Purpose**: Text embeddings for classification and section mapping
- **Size**: ~90 MB
- **Auto-download**: Yes (on first run)

### 2. spaCy NER Model
- **Model**: `en_core_web_sm`
- **Purpose**: Named Entity Recognition for evidence extraction
- **Size**: ~12 MB
- **Installation**:
  ```bash
  python -m spacy download en_core_web_sm
  ```

### 3. ChromaDB Vector Database
- **Purpose**: Store and search legal section embeddings
- **Auto-created**: Yes (on first run)
- **Location**: `mcp/server/chroma_db/`

## Setup Instructions

### Backend Models

1. **Activate virtual environment**:
   ```bash
   cd mcp/server
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies** (includes model libraries):
   ```bash
   pip install -r requirements.txt
   ```

3. **Download spaCy model**:
   ```bash
   python -m spacy download en_core_web_sm
   ```

4. **First run** (auto-downloads sentence transformer):
   ```bash
   python main.py
   ```
   
   The sentence transformer model will be automatically downloaded to:
   - `~/.cache/huggingface/` (Linux/Mac)
   - `C:\Users\<username>\.cache\huggingface\` (Windows)

### Frontend Dependencies

```bash
cd mcp/client
npm install
```

This will download all Node.js dependencies (not included in repository).

## Model Storage

### Excluded from Git
The following directories are excluded via `.gitignore`:
- `mcp/server/models/` - Downloaded ML models
- `mcp/client/node_modules/` - Node.js dependencies
- `mcp/client/release/` - Electron build artifacts

### Why Models Are Excluded
- **Size**: Models can be 100MB-1GB+
- **Availability**: Models are freely available from Hugging Face and spaCy
- **Updates**: Models can be updated independently
- **Repository Size**: Keeps the Git repository lightweight

## Troubleshooting

### Model Download Issues

**Problem**: Sentence transformer fails to download
```bash
# Manual download
from sentence_transformers import SentenceTransformer
model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
```

**Problem**: spaCy model not found
```bash
# Reinstall spaCy model
python -m spacy download en_core_web_sm --force
```

**Problem**: ChromaDB errors
```bash
# Delete and recreate
rm -rf mcp/server/chroma_db/
# Restart server (will recreate automatically)
```

## Model Versions

Current tested versions:
- **sentence-transformers**: 2.2.0+
- **spaCy**: 3.7.0+
- **transformers**: 4.30.0+

## Alternative: Manual Model Download

If automatic download fails, you can manually download models:

### Sentence Transformer
```python
from sentence_transformers import SentenceTransformer

# Download and save
model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
model.save('mcp/server/models/sentence-transformer')
```

### spaCy
```bash
# Download to specific location
python -m spacy download en_core_web_sm
```

## Production Deployment

For production deployments:

1. **Pre-download models** during build/deployment
2. **Cache models** in deployment environment
3. **Use model versioning** for consistency
4. **Monitor model updates** from Hugging Face

## Support

If you encounter model-related issues:
1. Check internet connection
2. Verify Python version (3.8+)
3. Check disk space (need ~500MB free)
4. Review error logs in terminal
5. Try manual download methods above

---

**Note**: The first run will take longer due to model downloads. Subsequent runs will be faster as models are cached.

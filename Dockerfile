FROM python:3.11-slim

# Install Tesseract + languages + video/image deps
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    tesseract-ocr-tam \
    tesseract-ocr-hin \
    tesseract-ocr-eng \
    libtesseract-dev \
    ffmpeg \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Default Tesseract path (Linux)
ENV TESSERACT_CMD=/usr/bin/tesseract

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8080"]

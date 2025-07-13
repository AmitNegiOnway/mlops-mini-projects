FROM python:3.10-slim

WORKDIR /app

# Install system dependencies for nltk and pip packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
COPY flask_app/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Download nltk resources
RUN python -m nltk.downloader stopwords wordnet

# Copy app and model
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]

# Stage 1: Build Stage
FROM python:3.10 AS build

WORKDIR /app

# Copy files
COPY flask_app/requirements.txt /app/
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

# ✅ Install dependencies here so nltk module is available
RUN pip install --no-cache-dir -r requirements.txt

# ✅ Now download NLTK data
RUN python -m nltk.downloader stopwords wordnet

# Stage 2: Final Stage
FROM python:3.10-slim AS final

WORKDIR /app

COPY --from=build /app /app

# ✅ Install packages in final image too
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]

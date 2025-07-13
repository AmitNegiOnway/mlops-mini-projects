# Stage 1: Build
FROM python:3.10 AS build

WORKDIR /app

COPY flask_app/requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

RUN python -m nltk.downloader stopwords wordnet


# Stage 2: Final
FROM python:3.10-slim AS final

WORKDIR /app

# ✅ Copy installed Python packages
COPY --from=build /usr/local/lib/python3.10 /usr/local/lib/python3.10

# ✅ Copy your app code
COPY --from=build /app /app

EXPOSE 5000

CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--timeout", "120", "app:app"]

# Stage 1: Build Stage
FROM python:3.10 AS build

WORKDIR /app

# Copy the requirements.txt file from the flask_app folder
COPY flask_app/requirements.txt /app/

# Copy app code and model files
COPY flask_app/ /app/
COPY models/vectorizer.pkl /app/models/vectorizer.pkl

# Download only the necessary NLTK data
RUN python -m nltk.downloader stopwords wordnet

# Stage 2: Final Stage
FROM python:3.10-slim AS final

WORKDIR /app

# Copy only the necessary files from the build stage
COPY --from=build /app /app

#  Install dependencies again in final stage
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]

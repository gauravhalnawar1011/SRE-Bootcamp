# Multi-stage Dockerfile for Flask REST API
# 1st Stage: Builder to install dependencies
FROM python:3.11-slim AS builder

WORKDIR /app

# Install system dependencies required for psycopg2
RUN apt-get update && apt-get install -y libpq-dev gcc python3-dev


# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# 2nd Stage: Minimal runtime image
FROM python:3.11-slim 

WORKDIR /app

# Install system dependencies for psycopg2
RUN apt-get update && apt-get install -y libpq-dev

# Copy installed dependencies from builder
COPY --from=builder /install /usr/local

# Copy application code
COPY . .

# Expose API port
EXPOSE 5000

# Set environment variables
ENV FLASK_ENV=production
ENV DATABASE_URL="postgresql://admin:admin@postgres-container:5432/students_db"

# Run application using run.py
CMD ["python3", "run.py"]

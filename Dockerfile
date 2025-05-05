# Use official Python image
FROM python:3.11-slim

# Set working directory inside container
WORKDIR /app

# Copy requirement and app files
COPY requirements.txt ./
COPY app/ ./app/
COPY tests/ ./tests/

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Set PYTHONPATH so Python knows where to find 'app'
ENV PYTHONPATH=/app

# Default command
CMD ["pytest"]
# Use a lightweight Python base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt to the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Pre-download the Hugging Face model to reduce runtime overhead
RUN python -c "from transformers import pipeline; pipeline('text2text-generation', model='google/flan-t5-base')"

# Copy the rest of the application files to the container
COPY . /app

# Expose port 5000 for the Flask application
EXPOSE 5000

# Command to run the Flask app
CMD ["python", "app.py"]

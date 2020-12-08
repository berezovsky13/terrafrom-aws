FROM python:3.8.0-buster

# Make a directory for our application
WORKDIR /app
# Install dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

# Run the application
CMD ["python", "index.py"]

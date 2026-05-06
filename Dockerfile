FROM python:3.7-slim
# Using old Python version (3.7) to trigger Trivy vulnerability scanner

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]

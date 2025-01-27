
FROM python:3.9-slim

WORKDIR /src
COPY ./src/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY ./src/ .

EXPOSE 8080
CMD ["python", "main.py"]

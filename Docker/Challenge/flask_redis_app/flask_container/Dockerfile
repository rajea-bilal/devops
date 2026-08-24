FROM python:3.10-slim

WORKDIR /app

RUN pip install --no-cache-dir flask redis gunicorn

COPY . .

EXPOSE 5004

CMD ["gunicorn", "--bind", "0.0.0.0:5004", "app:app"]
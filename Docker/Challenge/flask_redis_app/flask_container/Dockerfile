FROM python:3.10-slim 

WORKDIR /app

RUN pip install flask redis

COPY . . 

EXPOSE 5003

CMD ["python", "app.py"]        

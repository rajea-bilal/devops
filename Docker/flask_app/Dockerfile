
# Stage 1: Build Stage

FROM python:3.10-slim as Build

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
          pkg-config \
          gcc \
          default-libmysqlclient-dev \
      && rm -rf /var/lib/apt/lists/*


COPY . . 

RUN pip install flask mysqlclient 

# Stage 2: Final Stage
FROM python:3.10-slim 

WORKDIR /app

COPY --from=Build /app /app

EXPOSE 5003

CMD ["python", "app.py"]
# docker build -t taxi_ingest:v001 .

FROM python:3.9.1

RUN apt-get install wget
RUN pip install pandas sqlalchemy psycopg2-binary

WORKDIR /app

COPY ingest_data.py ingest_data.py

# ENTRYPOINT ["bash"] # this will run bash
ENTRYPOINT [ "python", "ingest_data.py" ]
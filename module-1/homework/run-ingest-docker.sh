#!/bin/bash


# dump zone data
URL="https://s3.amazonaws.com/nyc-tlc/misc/taxi+_zone_lookup.csv"
docker run -it \
  --network=pg-network \
  taxi_ingest:v003 \
    --user=root \
    --password=root \
    --host=pg-database \
    --port=5432 \
    --db=ny_taxi \
    --table_name=zones \
    --url=${URL}



# dump green taxi data
# URL="https://github.com/DataTalksClub/nyc-tlc-data/releases/download/green/green_tripdata_2019-09.csv.gz"
# docker run -it \
#   --network=pg-network \
#   taxi_ingest:v002 \
#     --user=root \
#     --password=root \
#     --host=pg-database \
#     --port=5432 \
#     --db=ny_taxi \
#     --table_name=green_taxi_trips \
#     --url=${URL}
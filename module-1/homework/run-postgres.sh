#!/bin/bash

docker run -it \
  -e POSTGRES_USER="root" \
  -e POSTGRES_PASSWORD="root" \
  -e POSTGRES_DB="ny_taxi" \
  -v $(pwd)/ny_taxi_postgres_data:/var/lib/postgresql/data \
  -p 5431:5432 \
  --network=pg-network \
  --name pg-database \
  postgres:13


# network: pg-network, which needs to be created first
# name: pg-database, which is the name of the container

# -p: port (forwarding a port from the host machine to the container) 5432 on host is occupied
# -e: environment variable
# -v: volume (mounting a directory from the host machine to the container)
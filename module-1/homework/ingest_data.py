import os
import pandas as pd
import argparse
from sqlalchemy import create_engine


def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    url = params.url
    csv_name = url.split('/')[-1]

    os.system(f"wget {url}")

    # create sqlalchemy engine to connect to postgres
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100_000)
    for idx, df in enumerate(df_iter):

        # NOTE: comment out this to dump the green taxi data
        # df.lpep_pickup_datetime = pd.to_datetime(df.lpep_pickup_datetime)
        # df.lpep_dropoff_datetime = pd.to_datetime(df.lpep_dropoff_datetime)

        if idx == 0:
            # create table schema
            df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

        # insert data
        df.to_sql(name=table_name, con=engine, if_exists='append')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', required=True, help='user name for postgres', default='root')
    parser.add_argument('--password', required=True, help='password for postgres', default='root')
    parser.add_argument('--host', required=True, help='host for postgres', default='localhost')
    parser.add_argument('--port', required=True, help='host port for postgres')
    parser.add_argument('--db', required=True, help='database name for postgres')
    parser.add_argument('--table_name', required=True, help='name of the table where we will write the results to')
    parser.add_argument('--url', required=True, help='url of the csv file')

    args = parser.parse_args()

    main(args)

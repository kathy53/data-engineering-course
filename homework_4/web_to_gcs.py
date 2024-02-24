"""
Run this script in a python venv
Run
    export GCP_GCS_BUCKET=dtc-data-lake-hw4
    for each env

"""

import requests
import os
import pandas as pd

from google.cloud import storage

bucket_name = os.environ.get("GCP_GCS_BUCKET")


def upload_to_gcs(bucket, object_name, local_file):
    """
    Ref: https://cloud.google.com/storage/docs/uploading-objects#storage-upload-object-python
    """

    client = storage.Client()
    bucket = client.bucket(bucket)
    blob = bucket.blob(object_name)
    blob.upload_from_filename(local_file)


def web_to_gcs(year, type):
    for month in range(1, 13):

        requested_url = f"https://github.com/DataTalksClub/nyc-tlc-data/releases/download/{type}/{type}_tripdata_{year}-{month:02d}.csv.gz"
        content = requests.get(requested_url)
        path_file = f"{type}_tripdata_{year}-{month:02d}.csv.gz"
        open(path_file, "wb").write(content.content)

        df = pd.read_csv(path_file, compression="gzip")

        import pdb

        pdb.set_trace()
        print(df.columns())

        path_file = path_file.replace(".csv.gz", ".csv")
        df.to_csv(path_file, index=False, header=False)

        upload_to_gcs(bucket_name, f"{type}/{path_file}", path_file)


# type: yellow, green or fhv
# web_to_gcs("2019", "green")
# web_to_gcs("2020", "green")
# web_to_gcs("2019", "yellow")
# web_to_gcs("2020", "yellow")
web_to_gcs("2019", "fhv")

from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
from os import path
import os
import pyarrow as pa
import pyarrow.parquet as pq
import json


if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter

config_path = path.join(get_repo_path(), 'io_config.yaml')
config_profile = 'default'
bucket_name = 'terraform-demo-de-zoomcamp'

table_name = 'ny_green_taxi_parquets'

cred = ConfigFileLoader(config_path, config_profile).get("GOOGLE_SERVICE_ACC_KEY")
with open('../cred.json', 'w') as fp:
    json.dump(cred, fp)

os.environ["GOOGLE_APPLICATION_CREDENTIAL"] = "../cred.json"
root_path = f"{bucket_name}/{table_name}"

@data_exporter
def export_data_to_google_cloud_storage(data: DataFrame, **kwargs) -> None:
    """
    Template for exporting data to a Google Cloud Storage bucket.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#googlecloudstorage
    """
    table = pa.Table.from_pandas(data)   
    gcs = pa.fs.GcsFileSystem()

    pq.write_to_dataset(
        table,
        root_path=root_path,
        partition_cols=["lpep_pickup_date"],
        filesystem=gcs
    )
    
    

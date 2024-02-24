# Homework week 4

## Set up files into BigQuery
- Upload files into Google Storage using the web_to_gcs.py file to create tables about fhv service.
- Use files from BigQuery to create green and yellow tables 

## Running DBT
For this homework, DBT was ran locally using the Dockerfile provided by DataTalks and connecting it with BigQuery.
The Dockerfile was modified to run DBT commmads in a terminal without using DBT Cloud.

Dockerfile modifications:
1. While running the project it was necessary to update versions:

dbt-core=1.7.8
bigquery=175

2. Add a package:

RUN pip install pytz

3. Change the entrypoint for "CMD sleep infinity"
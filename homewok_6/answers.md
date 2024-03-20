# Homework 6
## Resources
To answer this homework I used the Google virtual machine created for module-5.

__Question 1__ 
``` 
$ rpk version
v22.3.5 (rev 28b2443)
```
__Question 2__ 
``` 
$ rpk topic create test-topic
TOPIC       STATUS
test-topic  OK

```
__Question 3__
First install kafka
pip install kafka-python

Then opened ipython and run the next lines 
```
>> True
```
__Question 4__ 

```
Sent: {'number': 0}
Sent: {'number': 1}
Sent: {'number': 2}
Sent: {'number': 3}
Sent: {'number': 4}
Sent: {'number': 5}
Sent: {'number': 6}
Sent: {'number': 7}
Sent: {'number': 8}
Sent: {'number': 9}
took 0.51 seconds
```
The Flushing took more time

__Question 5__ 
``` 
import pandas as pd
columns_of_interest = [
    'lpep_pickup_datetime',
    'lpep_dropoff_datetime',
    'PULocationID',
    'DOLocationID',
    'passenger_count',
    'trip_distance',
    'tip_amount'
]
df_green = pd.read_csv('green_tripdata_2019-10.csv.gz', compression='gzip', usecols=columns_of_interest) 
```
```
topic_name = 'green-trips'
time0 = time.time()
for row in df_green.itertuples(index=False):
    row_dict = {col: getattr(row, col) for col in row._fields}
    producer.send(topic_name, value=row_dict)
    # print(row_dict)
producer.flush()
t1 = time.time()
print(f'took {(t1 - time0):.2f} seconds')
```
``` 
47.06 seconds
```
There were 476386 iterations and the rate was 10128.46it/s


__Question 6__ 
After providing schema the output was:
```
Row(lpep_pickup_datetime='2019-10-01 00:26:02', lpep_dropoff_datetime='2019-10-01 00:39:58', PULocationID=112, DOLocationID=196, passenger_count=1.0, trip_distance=5.88, tip_amount=0.0)
```
__Question 7__

For this question please review the notebook hw6_question7.ipynt 



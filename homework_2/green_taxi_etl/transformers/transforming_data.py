if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    '''
    Add three assertions:
    vendor_id is one of the existing values in the column (currently)
    '''
    data = data[(data['passenger_count']>0)]
    data['lpep_pickup_date'] = data['lpep_pickup_datetime'].dt.date
    
    data = data.rename(columns={col:col.lower() for col in data.columns})

    for col in data.columns:
        if "id" in col:
            data.rename(columns={col:col.replace("id", "_id")},inplace=True)
            
    data = data[(data['trip_distance']>0)]

    return data


@test
def test_output(output, *args) -> None:
    assert output is not None, 'The output is undefined'
    assert "vendor_id" in output.columns, 'vendor_id is not one of the existing values in the column (currently)'
    assert all(output['passenger_count']) > 0, 'passenger_count is not greater than 0'
    assert all(output['trip_distance']) > 0, 'trip_distance is not greater than 0'

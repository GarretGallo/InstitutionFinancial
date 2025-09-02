import boto3
from uuid import uuid4

def lambda_handler(event, context):
    s3 = boto3.client("s3")
    dynamodb = boto3.resource('dynamodb')
    dynamoTable = dynamodb.Table('insert-table-name-here')

    d = event.get('detail', {})
    if d:
        bucket_name = d.get('bucket', {}).get('name')
        object_key  = d.get('object', {}).get('key')
        size        = d.get('object', {}).get('size', -1)
        event_name  = event.get('detail-type', 'Object Created')
        event_time  = event.get('time')

        if bucket_name and object_key:
            dynamoTable.put_item(Item={
                'Resource_id': str(uuid4()),
                'Bucket': bucket_name,
                'Object': object_key,
                'Size': size,
                'Event': event_name,
                'EventTime': event_time
            })
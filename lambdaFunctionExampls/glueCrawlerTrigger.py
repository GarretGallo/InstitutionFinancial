import json
import boto3

glue = boto3.client('glue')
s3 = boto3.client('s3')

def lambda_handler(event, context):
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    file_key = event['Records'][0]['s3']['object']['key']
    crawler_name = 'insert-crawler-name-here'

    try:
        response = glue.start_crawler(Name=crawler_name)
        print(f"Started crawler {crawler_name}")
    except Exception as e:
        print(f"Error starting crawler: {e}")
        raise e
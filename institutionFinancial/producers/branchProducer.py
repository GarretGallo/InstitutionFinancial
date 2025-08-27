import json
import boto3
import random
import uuid
from faker import Faker
from time import sleep
from datetime import date

fake = Faker()

BRANCH_LOCATIONS = {
    "United States": ["New York, NY", "Los Angeles, CA", "Philadelphia, PA", "Miami, FL"],
    "Japan": ["Tokyo", "Kyoto"],
    "Australia": ["Sydney", "Melbourne"],
    "France": ["Paris"],
    "Brazil": ["São Paulo"]
}

def branch_generator():
    branchId = str(uuid.uuid4())
    branchAddress = fake.street_address()
    country = random.choice(list(BRANCH_LOCATIONS.keys()))
    city = random.choice(list(BRANCH_LOCATIONS[country]))
    openingDate = fake.date_between(start_date="-10y", end_date="-1y").isoformat()

    branch = {
        'branchId': branchId,
        'branchAddress': branchAddress,
        'branchCity': city,
        'branchCountry': country,
        'branchOpeningDate': openingDate,
    }

    return branch

def main():
    AWS_ACCESS_KEY = "+++"
    AWS_SECRET_KEY = "+++"
    AWS_REGION_NAME = "us-east-1"

    kinesis_client = boto3.client('kinesis',
                                  aws_access_key_id=AWS_ACCESS_KEY,
                                  aws_secret_access_key=AWS_SECRET_KEY,
                                  region_name=AWS_REGION_NAME)
    kinesis_stream = 'branchStream'

    txn = branch_generator()
    data=json.dumps(txn).encode('utf-8')
    partitionKey = txn['branchId']

    response = kinesis_client.put_record(StreamName=kinesis_stream,
                                         Data=data,
                                         PartitionKey= partitionKey)
    print(f'Response Code: {response["ResponseMetadata"]["HTTPStatusCode"]}')
    sleep(0.25)

main()

"""if __name__ == "__main__":
    for _ in range(3):
        test = branch_generator()
        print(test)"""
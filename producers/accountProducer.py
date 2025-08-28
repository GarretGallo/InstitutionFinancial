import json
import boto3
import random
import uuid
from faker import Faker
from time import sleep

fake = Faker()

ACCOUNT_TYPE = ['Savings', 'Checking', 'Investment', 'Money Market Account',
                'Business Account', 'Certificate of Deposit Accounts']

def accounts_generator():
    accountId = str(uuid.uuid4())
    accountType = random.choice(ACCOUNT_TYPE)
    customerId = str(uuid.uuid4())
    openingDate = fake.date_time_between_dates(datetime_start='-1y', datetime_end='now').isoformat()
    balance = random.randint(100, 500000)
    status = random.choice(['Active', 'Inactive', 'Frozen', 'Closed'])

    account = {
        'accountId': accountId,
        'accountType': accountType,
        'customerId': customerId,
        'openingDate': openingDate,
        'balance': balance,
        'status': status,
    }

    return account

def main():
    AWS_ACCESS_KEY = "+++"
    AWS_SECRET_KEY = "+++"
    AWS_REGION_NAME = "us-east-1"

    kinesis_client = boto3.client('kinesis',
                                  aws_access_key_id=AWS_ACCESS_KEY,
                                  aws_secret_access_key=AWS_SECRET_KEY,
                                  region_name=AWS_REGION_NAME)
    kinesis_stream = 'accountsStream'

    txn = accounts_generator()
    data=json.dumps(txn).encode('utf-8')
    partitionKey = txn['accountId']

    response = kinesis_client.put_record(StreamName=kinesis_stream,
                                         Data=data,
                                         PartitionKey= partitionKey)
    print(f'Response Code: {response["ResponseMetadata"]["HTTPStatusCode"]}')
    sleep(0.25)

main()

"""if __name__ == "__main__":
    for _ in range(3):
        test = accounts_generator()
        print(test)"""
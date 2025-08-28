import json
import boto3
import random
import uuid
from faker import Faker
from time import sleep

fake = Faker()

CURRENCY_LOCATIONS = {
    "USD": ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Miami, FL", "Philadelphia, PA",
                      "Phoenix, AZ", "San Antonio, TX", "San Diego, CA", "Dallas, TX", "Austin, TX", "San Jose, CA",
                      "Denver, CO", "Seattle, WA", "Boston, MA", "Atlanta, GA", "Las Vegas, NV", "Orlando, FL",
                      "Portland, OR", "Washington, DC"],
    "EUR": ["Paris", "Marseille", "Lyon"],
    "JPY": ["Tokyo", "Osaka", "Kyoto"],
    "BRL": ["Sao Paulo", "Rio de Janeiro", "Brasília"],
    "AUD": ["Sydney", "Melbourne", "Brisbane"]
}

MERCHANTS = ["Amazon", "Walmart", "Target", "Costco", "Starbucks", "Uber", "Lyft", "McDonald's",
             "Apple", "Google Play", "Netflix", "Spotify", "Best Buy", "Home Depot", "Lowes",
             "Shell Gas", "Chevron", "Airbnb", "Delta Airlines", "American Airlines"]

currencyRandom = random.choice(list(CURRENCY_LOCATIONS.keys()))
locationRandom = random.choice(CURRENCY_LOCATIONS[currencyRandom])


def financial_transactions_generator():
    transactionId = str(uuid.uuid4())
    transactionAmount = random.randint(10, 10000)
    accountId = str(uuid.uuid4())
    customerId = str(uuid.uuid4())
    transactionDateTime = fake.date_time_between_dates(datetime_start='-1y', datetime_end='now').isoformat()
    transactionLocation = locationRandom
    currency = currencyRandom
    exchangeRate = round(random.uniform(0.0, 1.5), 4)
    merchantId = random.choice(MERCHANTS)
    transactionType = random.choice(['Credit', 'Debit', 'Transfer', 'Withdraw', 'Deposit'])

    transaction = {
        "transactionId": transactionId,
        "transactionAmount": transactionAmount,
        'accountId': accountId,
        "customerId": customerId,
        "transactionDateTime": transactionDateTime,
        "transactionLocation": transactionLocation,
        "currency": currency,
        'exchangeRate': exchangeRate,
        "merchantId": merchantId,
        "transactionType": transactionType,
    }

    return transaction

def main():
    AWS_ACCESS_KEY = "+++"
    AWS_SECRET_KEY = "+++"
    AWS_REGION_NAME = "us-east-1"

    kinesis_client = boto3.client('kinesis',
                                  aws_access_key_id=AWS_ACCESS_KEY,
                                  aws_secret_access_key=AWS_SECRET_KEY,
                                  region_name=AWS_REGION_NAME)
    kinesis_stream = 'transactionsStream'

    txn = financial_transactions_generator()
    data=json.dumps(txn).encode('utf-8')
    partitionKey = txn['transactionId']

    response = kinesis_client.put_record(StreamName=kinesis_stream,
                                         Data=data,
                                         PartitionKey= partitionKey)
    print(f'Response Code: {response["ResponseMetadata"]["HTTPStatusCode"]}')
    sleep(0.25)

main()

#Test
"""if __name__ == "__main__":
    for _ in range(3):
        test = financial_transactions_generator()
        print(test)"""
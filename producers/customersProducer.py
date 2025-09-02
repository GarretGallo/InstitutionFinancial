import json
import boto3
import random
import uuid
from faker import Faker
from datetime import date
from time import sleep

fake = Faker()


LOCATIONS = {
    "United States": ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX", "Miami, FL", "Philadelphia, PA",
                      "Phoenix, AZ", "San Antonio, TX", "San Diego, CA", "Dallas, TX", "Austin, TX", "San Jose, CA",
                      "Denver, CO", "Seattle, WA", "Boston, MA", "Atlanta, GA", "Las Vegas, NV", "Orlando, FL",
                      "Portland, OR", "Washington, DC"],
    "France": ["Paris", "Marseille", "Lyon"],
    "Japan": ["Tokyo", "Osaka", "Kyoto"],
    "Brazil": ["São Paulo", "Rio de Janeiro", "Brasília"],
    "Australia": ["Sydney", "Melbourne", "Brisbane"]
}

countryRandom = random.choice(list(LOCATIONS.keys()))
cityRandom = random.choice(LOCATIONS[countryRandom])

def customers_generator():
    dateBirth = fake.date_between(start_date="-100y", end_date="-18y")
    today = date.today()
    age1 = today.year - dateBirth.year - ((today.month, today.day) < (dateBirth.month, dateBirth.day))

    customerId = str(uuid.uuid4())
    firstName = fake.first_name()
    lastName = fake.last_name()
    dob = dateBirth.isoformat()
    age = age1
    gender = random.choice(['Male', 'Female', 'Other'])
    joinDate = fake.date_time_between_dates(datetime_start='-1y', datetime_end='now').isoformat()
    mainBranchCountry = countryRandom
    mainBranchCity = cityRandom
    address = fake.street_address()
    country = countryRandom
    city = cityRandom
    SSN = fake.ssn()
    email = fake.email()
    phoneNumber = fake.phone_number()
    occupation = fake.job()
    salary = random.randint(35000, 250000)

    customer = {
        "customerId": customerId,
        "firstName": firstName,
        "lastName": lastName,
        "dob": dob,
        "age": age,
        "gender": gender,
        "joinDate": joinDate,
        "mainBranchCountry": mainBranchCountry,
        "mainBranchCity": mainBranchCity,
        "address": address,
        "country": country,
        "city": city,
        "SSN": SSN,
        "email": email,
        "phoneNumber": phoneNumber,
        "occupation": occupation,
        "salary": salary,
    }

    return customer

def main():
    AWS_ACCESS_KEY = "+++"
    AWS_SECRET_KEY = "+++"
    AWS_REGION_NAME = "us-east-1"

    kinesis_client = boto3.client('kinesis',
                                  aws_access_key_id=AWS_ACCESS_KEY,
                                  aws_secret_access_key=AWS_SECRET_KEY,
                                  region_name=AWS_REGION_NAME)
    kinesis_stream = 'customersStream'

    txn = customers_generator()
    data=json.dumps(txn).encode('utf-8')
    partitionKey = txn['customerId']

    response = kinesis_client.put_record(StreamName=kinesis_stream,
                                         Data=data,
                                         PartitionKey= partitionKey)
    print(f'Response Code: {response["ResponseMetadata"]["HTTPStatusCode"]}')
    sleep(0.25)

main()

#TEST
"""if __name__ == "__main__":
    for _ in range(3):
        test = customers_generator()
        print(test)"""

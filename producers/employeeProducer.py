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

DEPARTMENTS = {
    '101': "Retail Banking",
    '102': "Commercial Banking",
    '103': "Investment Banking",
    '104': "Wealth Management",
    '105': "Risk and Compliance",
    '106': "Information Technology",
    '107': "Human Resources"
}

def employee_generator():
    dateBirth = fake.date_between(start_date="-100y", end_date="-18y")
    today = date.today()
    age1 = today.year - dateBirth.year - ((today.month, today.day) < (dateBirth.month, dateBirth.day))

    employeeId = str(uuid.uuid4())
    employeeFirstName = fake.first_name()
    employeeLastName = fake.last_name()
    dob = dateBirth.isoformat()
    age = age1
    gender = random.choice(['Male', 'Female', 'Other'])
    branchCountry = random.choice(list(BRANCH_LOCATIONS.keys()))
    branchCity = random.choice(BRANCH_LOCATIONS[branchCountry])
    deptNo = random.choice(list(DEPARTMENTS.keys()))
    department = (DEPARTMENTS[deptNo])
    salary = random.randint(50000, 250000)
    startDate = fake.date_between(start_date="-10y", end_date="-30d").isoformat()
    address = fake.street_address()
    country = random.choice(list(LOCATIONS.keys()))
    city = random.choice(LOCATIONS[country])
    SSN = fake.ssn()
    email = fake.email()
    phoneNumber = fake.phone_number()

    employee = {
        "employeeId": employeeId,
        "employeeFirstName": employeeFirstName,
        "employeeLastName": employeeLastName,
        "dob": dob,
        "age": age,
        "gender": gender,
        "branchCountry": branchCountry,
        "branchCity": branchCity,
        "department": department,
        'deptNo': deptNo,
        "salary": salary,
        "startDate": startDate,
        "address": address,
        "country": country,
        "city": city,
        "phoneNumber": phoneNumber,
        'SSN': SSN,
        "email": email,
        "phone": phoneNumber,
    }

    return employee

def main():
    AWS_ACCESS_KEY = "+++"
    AWS_SECRET_KEY = "+++"
    AWS_REGION_NAME = "us-east-1"

    kinesis_client = boto3.client('kinesis',
                                  aws_access_key_id=AWS_ACCESS_KEY,
                                  aws_secret_access_key=AWS_SECRET_KEY,
                                  region_name=AWS_REGION_NAME)
    kinesis_stream = 'employeeStream'

    txn = employee_generator()
    data=json.dumps(txn).encode('utf-8')
    partitionKey = txn['employeeId']

    response = kinesis_client.put_record(StreamName=kinesis_stream,
                                         Data=data,
                                         PartitionKey= partitionKey)
    print(f'Response Code: {response["ResponseMetadata"]["HTTPStatusCode"]}')
    sleep(0.25)

main()

#TEST
"""if __name__ == "__main__":
    for _ in range(3):
        test = employee_generator()
        print(test)"""
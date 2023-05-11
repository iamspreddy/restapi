import requests

url = 'https://your-employee-api.com/employees'

# list of 10 employees with their data in JSON format
employees = [
    {
        "name": "Rama",
        "age": "23",
        'gender': 'male',
        "designation": "Engineering 1"
    },
    {
        "name": "beema",
        "age": "25",
        'gender': 'male',
        "designation": "Engineering 2"
    },
    {
        "name": "seetha",
        "age": "21",
        'gender': 'Female',
        "designation": "Engineering 3"
    },
    {
        "name": "Geetha",
        "age": "26",
        'gender': 'male',
        "designation": "Engineering 4 "
    },
    {
        "name": "Ramesh",
        "age": "33",
        'gender': 'male',
        "designation": "Engineering 5"
    },
    {
        "name": "raghava",
        "age": "23",
        'gender': 'male',
        "designation": "Engineering 6"
    },
    {
        "name": "Jawahar",
        "age": "29",
        'gender': 'male',
        "designation": "Engineering 7"
    },
    {
        "name": "Ravi",
        "age": "33",
        'gender': 'male',
        "designation": "Engineering 8"
    },
    {
        "name": "Dhoni",
        "age": "38",
        'gender': 'male',
        "designation": "Engineering 9"
    },
    {
        "name": "sagar",
        "age": "28",
        'gender': 'male',
        "designation": "Engineering 10"
    }
]

# make the POST request for each employee
for employee in employees:
    response = requests.post(url, json=employee)
    if response.status_code == 201:
        print(f"Employee {employee['name']} created successfully.")
    else:
        print(f"Failed to create employee {employee['name']}.")

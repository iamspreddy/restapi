import requests
import json

url = 'https://jsonplaceholder.typicode.com/posts'
employees = [
    {
        "name": "rama",
        "age": 23,
        "gender": "male",
        "designation": "Engineering 1"
    },
    {
        "name": "beema",
        "age": 25,
        "gender": "male",
        "designation": "Engineering 2"
    },
    {
        "name": "seetha",
        "age": 41,
        "gender": "female",
        "designation": "Engineering 3"
    },
    {
        "name": "geetha",
        "age": 26,
        "gender": "female",
        "designation": "Engineering 4 "
    },
    {
        "name": "Ramesh",
        "age": 33,
        "gender": "male",
        "designation": "Engineering 5"
    },
    {
        "name": "raghava",
        "age": 23,
        "gender": "male",
        "designation": "Engineering 6"
    },
    {
        "name": "jawahar",
        "age": 29,
        "gender": "male",
        "designation": "Engineering 7"
    },
    {
        "name": "ravi",
        "age": 33,
        "gender": "male",
        "designation": "Engineering 8"
    },
    {
        "name": "dhoni",
        "age": 48,
        "gender": "male",
        "designation": "Engineering 9"
    },
    {
        "name": "sanjay",
        "age": 28,
        "gender": "male",
        "designation": "Engineering 10"
    }
]

for employee in employees:
    response = requests.post(url, json=employee)
    if response.status_code == 201:
        print(f"Employee {employee['name']} created successfully.")
    else:
        print(f"Failed to create employee {employee['name']}.")

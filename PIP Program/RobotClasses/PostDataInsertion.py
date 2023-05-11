import requests
import json

url = 'https://restful-booker.herokuapp.com/booking'

headers = {
    'Content-Type': 'application/json'
}

employees = [
    {
        "name": "Rama",
        "age": "23",
        "gender": "male"
    },
    {
        "name": "beema",
        "age": "25",
        "gender": "male"
    },
    {
        "name": "seetha",
        "age": "21",
        "gender": "Female"
    },
    {
        "name": "Geetha",
        "age": "26",
        "gender": "male"
    },
    {
        "name": "Ramesh",
        "age": "33",
        "id": "s1",
        "gender": "male"
    },
    {
        "name": "raghava",
        "age": "23",
        "gender": "male"
    },
    {
        "name": "jawahar",
        "age": "29",
        "gender": "male"
    },
    {
        "name": "Ravi",
        "age": "33",
        "gender": "male"
    },
    {
        "name": "Dhoni",
        "age": "38",
        "gender": "male"
    },
    {
        "name": "sagar",
        "age": "28",
        "gender": "male"
    }
]


response = requests.post(url, headers=headers, data=json.dumps(employees))

if response.status_code == 200:
    print("Booking created successfully!")
    print(response.json())
else:
    print("Error creating booking!")
    print(response.status_code)
    print(response.text)

# response1 = requests.get(url)
#
# if response1.status_code == 200:
#     data = response1.json()
#     print(data)
# else:
#     print("Failed to retrieve data.")
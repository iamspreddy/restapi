import requests
import json

url = 'https://restful-booker.herokuapp.com/booking'

headers = {
    'Content-Type': 'application/json'
}

employees = [
    {
        "0": {
            "name": "Rama",
            "age": "23",
            "gender": "male"
        },
        "1": {
            "name": "Beema",
            "age": "25",
            "gender": "male"
        },
        "2": {
            "name": "Seetha",
            "age": "21",
            "gender": "Female"
        },
        "3": {
            "name": "Geetha",
            "age": "26",
            "gender": "male"
        },
        "4": {
            "name": "Ramesh",
            "age": "33",
            "id": "s1",
            "gender": "male"
        },
        "5": {
            "name": "Raghava",
            "age": "23",
            "gender": "male"
        },
        "6": {
            "name": "Jawahar",
            "age": "29",
            "gender": "male"
        },
        "7": {
            "name": "Ravi",
            "age": "33",
            "gender": "male"
        },
        "8": {
            "name": "Dhoni",
            "age": "38",
            "gender": "male"
        },
        "9": {
            "name": "Sagar",
            "age": "28",
            "gender": "male"
        }
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
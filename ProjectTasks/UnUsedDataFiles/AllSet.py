import requests

url = 'https://api.github.com/repos/iamspreddy/restapi/contents/employees.json'
# https://iamspreddy.github.io/restapi/employees.json
token = "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"

headers = {
    "Authorization": f"Token {token}",
    "Content-Type": "application/json"
}

# Data to be sent in the POST request
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

response = requests.post(url, json=employees, headers=headers)

if response.status_code == 201:
    print("POST request successful")
else:
    print("Failed to make POST request:", response.text)

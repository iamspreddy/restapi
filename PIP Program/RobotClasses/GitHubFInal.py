import base64

import requests
import json
import os


url = 'https://iamspreddy.github.io/restapi/employees.json'

response = requests.get(url)
data = response.json()

if 'content' in data:
    content = data['content']
    # Decode the base64-encoded content
    decoded_content = base64.b64decode(content).decode('utf-8')
    print(decoded_content)
else:
    print("File not found or no content available.")

# Define the GitHub API endpoint URL and file path
owner = 'iamspreddy'  # Replace with your repository owner's username or organization name
repo = 'restapi'  # Replace with your repository name
file_path = 'employees.json'  # Replace with the file path where you want to add the employee data

# Convert the employees list to JSON format
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
# Access the 5th element (index 4)
fifth_element = employees[4]

# Print the data of the 5th element
print(fifth_element)

employee_data = json.dumps(employees)
access_token = os.environ.get('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')
headers = {
    'Authorization': f'Bearer {access_token}',
    'Content-Type': 'application/json',
}

payload = {
    'message': 'Add employee data',
    'content': employee_data,
}

# Make the POST request to add employee data
response = requests.post(url.format(owner=owner, repo=repo, file_path=file_path), headers=headers, json=payload)

if response.status_code == 201:
    print("Employee data added successfully.")
else:
    print("Failed to add employee data. Response:", response.text)

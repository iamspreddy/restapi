import requests
import json

url = 'https://your-api-endpoint.com/employees'

headers = {'Content-Type': 'application/json'}

employees = []

for i in range(10):
    employee = {
        'name': f'Employee {i+1}',
        'age': 25,
        'title': 'Software Engineer'
    }
    employees.append(employee)

data = json.dumps(employees)

response = requests.post(url, headers=headers, data=data)

print(response.status_code)
print(response.text)

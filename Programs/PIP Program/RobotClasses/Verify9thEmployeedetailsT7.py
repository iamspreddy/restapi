import requests

url = 'https://your-employee-api.com/employees'

response = requests.get(url)

if response.status_code == 200:
    employees = response.json()
    # Print all 9 employees details
    print(employees)
else:
    print('Failed to retrieve employee data')

import requests

url = 'https://restful-booker.herokuapp.com/booking'
response = requests.get(url)

if response.status_code == 200:
    employees = response.json()
    # Print all employees
    print(employees)
    # Print the 5th employee
    print(employees[11])
else:
    print('Failed to retrieve 10th employee data, it got deleted')

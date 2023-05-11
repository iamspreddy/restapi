import requests

url = 'https://iamspreddy.github.io/restapi/employees.json'

# Make a GET request to retrieve the data
response = requests.get(url)

if response.status_code == 200:
    employee_data = response.json()

    if len(employee_data) >= 5:
        fifth_employee = employee_data[4]
        print("Fifth employee data:")
        print(fifth_employee)
    else:
        print("Insufficient data to retrieve the fifth employee.")

    print("Retrieved data:")
    for employee in employee_data:
        print(employee)
else:
    print("Failed to retrieve data.")

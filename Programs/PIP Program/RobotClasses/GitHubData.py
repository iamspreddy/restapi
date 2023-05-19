import requests

url = 'https://api.github.com/repos/iamspreddy/restapi/contents/employees.json'

# list of 10 employees with their data in JSON format
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


# make the POST request for each employee

for employee in employees:
    response = requests.post(url, json=employee)
    if response.status_code == 201:
        print(f"Employee {employee['name']} created successfully.")
        created_employee = response.json()
        print(created_employee)
    else:
        print(f"Failed to create employee {employee['name']}.")

# Make a GET request to retrieve the data
response = requests.get(url)
if response.status_code == 200:
    retrieved_data = response.json()
    print(retrieved_data)
    if len(retrieved_data) >= 5:
        fifth_employee = retrieved_data[4]
        print("Fifth employee data:")
        print(fifth_employee)
    else:
        print("Insufficient data to retrieve the fifth employee.")
    print("Retrieved data:")
    for data in retrieved_data:
        print(data)

else:
    print("Failed to retrieve data.")


# Edit the designation of the 5th employee
update_employee = employees[4]  # Assuming the 5th employee is at index 4
update_employee['designation'] = 'New Designation'
update_url = f"{url}/{update_employee['id']}"  # Assuming the employee has an 'id' field
response = requests.put(update_url, json=update_employee)
if response.status_code == 200:
    print("Designation of the 5th employee updated successfully.")
else:
    print("Failed to update the designation of the 5th employee.")

# List all employees and verify the updated designation
response = requests.get(url)
if response.status_code == 200:
    employee_data = response.json()
    for employee in employee_data:
        print(employee)
else:
    print("Failed to retrieve employee data.")
# Delete the 10th employee
delete_url = f"{url}/10"  # Assuming the 10th employee has ID 10
response = requests.delete(delete_url)
if response.status_code == 200:
    print("10th employee deleted successfully.")
else:
    print("Failed to delete 10th employee.")


# Check if the 10th employee can be viewed
get_url = f"{url}/10"  # Assuming the 10th employee has ID 10
response = requests.get(get_url)
if response.status_code == 404:
    print("The 10th employee cannot be viewed as it has been deleted.")
else:
    print("The 10th employee can still be viewed.")

# List all employees and check how many can be viewed
response = requests.get(url)
if response.status_code == 200:
    employee_data = response.json()
    print(f"Total employees: {len(employee_data)}")
    for employee in employee_data:
        print(employee)
else:
    print("Failed to retrieve employee data.")

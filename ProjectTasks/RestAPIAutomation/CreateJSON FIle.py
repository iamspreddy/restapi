import json

# Create a list to hold the employee data
employees = []

# Generate 10 employee entries
for i in range(1, 11):
    employee = {
        "id": i,
        "name": f"Employee {i}",
        "department": "HR" if i % 2 == 0 else "IT"
    }
    employees.append(employee)

# Write the employee data to a JSON file
with open("../APITasks/employees.json", "w") as file:
    json.dump(employees, file, indent=4)

print("Employee data created in employees.json file.")

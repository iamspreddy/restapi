from fastapi import FastAPI

app = FastAPI()


# Create an in-memory database to store employee details
employees = []


# Model for the employee
class Employee:
    def __init__(self, id, name, department):
        self.id = id
        self.name = name
        self.department = department


# Insert a new employee
@app.post("/employees")
def create_employee(employee: Employee):
    employees.append(employee)
    return {"message": "Employee created successfully"}


# Delete an employee by ID
@app.delete("/employees/{employee_id}")
def delete_employee(employee_id: int):
    for employee in employees:
        if employee.id == employee_id:
            employees.remove(employee)
            return {"message": "Employee deleted successfully"}
    return {"message": "Employee not found"}


# Fetch all employees
@app.get("/employees")
def get_employees():
    return employees


# Fetch an employee by ID
@app.get("/employees/{employee_id}")
def get_employee(employee_id: int):
    for employee in employees:
        if employee.id == employee_id:
            return employee
    return {"message": "Employee not found"}

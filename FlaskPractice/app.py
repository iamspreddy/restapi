from fastapi import FastAPI

app = FastAPI()

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


@app.get("/")
async def root():
    return {"message": "Hello World"}


@app.get("/emp_list")
async def get_emp_data():
    return employees


@app.post("/emp1 details")
async def adding_emp_data(name: str, age: int, gender: str):
    emp1 = {
        "name": name,
        "age": age,
        "gender": gender
    }
    employees.append(emp1)
    return emp1


@app.delete("/delete emp")
async def delete_emp_data(name: str):
    emp1 = {
        "name": name,
    }
    for emp in employees:
        for k, v in emp.items():
            if k == name:
                del emp
    return "deleted emp record"

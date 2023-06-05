import requests
import json
import base64


repo_owner = "spreddy559"
repo_name = "spreddy1"
file_path = "employees.json"
github_repo_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/contents/{file_path}"
#print(github_repo_url)
token = "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"
employee_data = {}
# Fetch the latest sha value for the employees.json file
headers = {
    "Authorization": f"Bearer {token}",
    "Accept": "application/vnd.github.v3+json"
}

response = requests.get(github_repo_url, headers=headers)
if response.status_code == 200:
    file_info = response.json()
    sha = file_info["sha"]
else:
    print("Failed to fetch file info:", response.text)
    sha = None

    # Fetch employee data from the REST API

employee_data = [
    {
        "name": "Rama",
        "age": "23",
        "gender": "male"
    },
    {
        "name": "Beema",
        "age": "25",
        "gender": "male"
    },
    {
        "name": "Seetha",
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
        "designation": "softwareEngineer",
        "gender": "male"
    },
    {
        "name": "Raghava",
        "age": "23",
        "gender": "male"
    },
    {
        "name": "Jawahar",
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
        "name": "Sagar",
        "age": "28",
        "gender": "male"
    }
]
# Add employee data to the repository
employee_data_json = json.dumps(employee_data)
encoded_content = base64.b64encode(employee_data_json.encode()).decode()

data = {
    "message": "Add employee data",
    "content": encoded_content,
    "sha": sha
}

response = requests.put(github_repo_url, json=data, headers=headers)

if response.status_code == 200:
    print("Employee data added successfully to the repository")
else:
    print("Failed to add employee data to the repository:", response.text)
print(employee_data)
import requests
import json
import base64
import random
import string

repo_owner = "spreddy559"
repo_name = "spreddy1"
file_path = "employees.json"
github_repo_url = f"https://api.github.com/repos/{repo_owner}/{repo_name}/contents/{file_path}"
token = "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"

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

# Generate random employee data
employee_data = []
for _ in range(10):
    employee = {
        "name": ''.join(random.choice(string.ascii_letters) for _ in range(5)),
        "age": str(random.randint(20, 40)),
        "gender": random.choice(["male", "female"]),
        "designation": random.choice(["Engineer", "Manager", "Analyst"])
    }
    employee_data.append(employee)

# Add employee data to the repository
employee_data_json = json.dumps(employee_data)
encoded_content = base64.b64encode(employee_data_json.encode()).decode()

data = {
    "message": "Add employee data",
    "content": encoded_content,
    "sha": sha
}

if sha is not None:
    # Update the file using a PUT request
    response = requests.put(github_repo_url, json=data, headers=headers)
else:
    # Create a new file using a POST request
    response = requests.post(github_repo_url, json=data, headers=headers)

if response.status_code == 200:
    print("Employee data added successfully to the repository")
else:
    print("Failed to add employee data to the repository:", response.text)

print(employee_data)

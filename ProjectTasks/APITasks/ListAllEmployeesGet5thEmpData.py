import base64

import requests
import json

# Replace with your GitHub repository details
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
    content = file_info["content"]
    encoded_content = content.encode()
    decoded_content = base64.b64decode(encoded_content).decode()
    employee_data = json.loads(decoded_content)

    # Print all employee data in indexed format
    print("All Employees' Data:")
    for index, employee in enumerate(employee_data):
        print(f"Index {index}: {employee}")

    # Print the data of the 5th employee
    fifth_employee_index = 4  # Index 4 corresponds to the 5th employee
    if fifth_employee_index < len(employee_data):
        fifth_employee = employee_data[fifth_employee_index]
        print("\nData of the 5th Employee:")
        print(fifth_employee)
    else:
        print("\nData of the 5th Employee not found.")
else:
    print("Failed to fetch file info:", response.text)

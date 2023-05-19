import base64
import requests
import json


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

    # Modify the designation of the 5th employee
    fifth_employee_index = 4  # Index 4 corresponds to the 5th employee
    if fifth_employee_index < len(employee_data):
        fifth_employee = employee_data[fifth_employee_index]
        print("Before update designation",fifth_employee)
        fifth_employee["designation"] = "Manager"  # Modify the designation to "Tester"

        # Encode the modified employee data
        encoded_content = base64.b64encode(json.dumps(employee_data).encode()).decode()

        # Prepare the data for the PUT request
        data = {
            "message": "Update employee designation",
            "content": encoded_content,
            "sha": sha
        }

        # Send the PUT request to update the file
        response = requests.put(github_repo_url, json=data, headers=headers)

        if response.status_code == 200:
            print("Employee designation updated successfully.")
        else:
            print("Failed to update employee designation:", response.text)
    else:
        print("Data of the 5th employee not found.")
else:
    print("Failed to fetch file info:", response.text)
print(employee_data[fifth_employee_index])
print(employee_data)
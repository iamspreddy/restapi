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

    # Verify the 10th employee is deleted
    tenth_employee_index = 9  # Index 9 corresponds to the 10th employee
    if tenth_employee_index < len(employee_data):
        del employee_data[tenth_employee_index]
        print("10th employee deleted successfully.")

        # Verify the 10th employee is not in the employee_data
        if tenth_employee_index not in range(len(employee_data)):
            print("The 10th employee has been successfully deleted.")
        else:
            print("The 10th employee was not deleted.")
    else:
        print("10th employee not found.")
else:
    print("Failed to fetch file info:", response.text)

print("Latest Employee data",employee_data)

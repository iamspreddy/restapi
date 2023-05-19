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

    # Delete the 10th employee
    tenth_employee_index = 9  # Index 9 corresponds to the 10th employee
    if tenth_employee_index < len(employee_data):
        del employee_data[tenth_employee_index]
        print("10th employee deleted successfully.")
    else:
        print("10th employee not found.")

    # Convert the modified employee_data back to JSON
    updated_content = json.dumps(employee_data).encode()
    encoded_content = base64.b64encode(updated_content).decode()

    # Update the file on GitHub with the modified content
    update_data = {
        "message": "Delete 10th employee",
        "content": encoded_content,
        "sha": sha
    }

    update_response = requests.put(github_repo_url, headers=headers, json=update_data)
    if update_response.status_code == 200:
        print("File updated successfully on GitHub.")
    else:
        print("Failed to update file on GitHub:", update_response.text)
else:
    print("Failed to fetch file info:", response.text)
print(employee_data)

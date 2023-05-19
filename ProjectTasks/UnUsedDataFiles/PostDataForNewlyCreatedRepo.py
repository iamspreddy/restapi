import requests

repo_name = "spreddy"
token = "<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>"

headers = {
    "Authorization": f"Bearer {token}",
    "Accept": "application/vnd.github.v3+json"
}

# Create employee data files
for i in range(10):
    filename = f"employee_{i}.txt"
    file_content = f"This is employee {i}'s data."
    file_data = {
        "path": filename,
        "message": f"Add {filename}",
        "content": file_content,
        "branch": "main"
    }

    file_url = f"https://api.github.com/repos/{repo_name}/contents/{filename}"

    response = requests.put(file_url, json=file_data, headers=headers)

    if response.status_code == 201:
        print(f"Created {filename}")
    else:
        print(f"Failed to create {filename}: {response.text}")

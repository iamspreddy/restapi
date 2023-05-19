import requests

url = "https://api.github.com/iamspreddy/spreddy"
token = "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"

headers = {
    "Authorization": f"Bearer {token}",
    "Accept": "application/vnd.github.v3+json"
}

data = {
    "name": "my-new-repo",
    "description": "This is a new repository created via API",
    "private": False
}

response = requests.post(url, json=data, headers=headers)

if response.status_code == 201:
    print("Repository created successfully")
else:
    print("Failed to create repository:", response.text)

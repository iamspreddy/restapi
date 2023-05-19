import requests

url = "https://api.github.com/user/repos"
token = "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"

headers = {
    "Authorization": f"Bearer {token}",
    "Accept": "application/vnd.github.v3+json"
}

data = {
    "name": "spreddy1",
    "description": "This is a new repository created via API",
    "private": False
}

response = requests.post(url, json=data, headers=headers)

if response.status_code == 201:
    print("Repository created successfully")
else:
    print("Failed to create repository:", response.text)

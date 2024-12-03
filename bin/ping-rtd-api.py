import requests

ua = requests.Session()

API_URL = "https://readthedocs.org/api/v3/"

res = ua.get(API_URL)
print(res.request.headers)
res.raise_for_status()

body = res.json()
print(body)

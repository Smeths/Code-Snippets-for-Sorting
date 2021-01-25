import requests
r = requests.get('https://api.github.com/user', auth=('smeths', 'Smeggas77'))
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
print(r.text)
print(r.json())

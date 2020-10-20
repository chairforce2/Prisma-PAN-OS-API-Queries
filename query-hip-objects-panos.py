import requests

url = "https://INSERT+YOUR+FW+PANORAMA+IP+HERE/restapi/9.0/Objects/GlobalProtectHIPObjects?location=device-group&device-group=Mobile_User_Device_Group&key=INSERT+YOUR+API+KEY+HERE"

payload = {}
headers= {}

response = requests.request("GET", url, headers=headers, data = payload, verify=False)

print(response.text.encode('utf8'))


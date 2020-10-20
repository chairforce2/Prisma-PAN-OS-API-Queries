import requests

url = "https://api.gpcloudservice.com/getPrismaAccessIP/v2"

payload = "{\n\"serviceType\": \"gp_gateway\",\n\"addrType\": \"all\",\n\"location\": \"all\"\n   }"
headers = {
  'header-api-key': '_insert_your_api_key_here',
  'Content-Type': 'text/plain'
}

response = requests.request("POST", url, headers=headers, data = payload, verify=False)

print(response.text.encode('utf8'))
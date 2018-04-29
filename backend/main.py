import requests
import json
import base64

###Change URL and don't hardcode
url = ""
audio = base64.b64encode(requests.get(url).content)

###speech_file = "fw.raw"
###with open(speech_file, 'rb') as speech:
###speech_content = base64.b64encode(speech.read())

data = {
    'audio': {
        'content': audio.decode('UTF-8')
    },
    'config': {
        'encoding': "LINEAR16",
        "sampleRateHertz": 16000,
        "languageCode": "en-US"
}
}
headers = {'Content-type': 'application/json'}
api = requests.post(
                    "https://speech.googleapis.com/v1/speech:recognize?key=YOUR_API_KEY",
                    data=json.dumps(data), headers = headers)

print(api.json())

#Parse

sentences_parsed = ""




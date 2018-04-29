import requests
import json
import base64
import firebase_admin
from firebase_admin import credentials
from firebase_admin import storage
from flask import Flask, jsonify, request

cred = credentials.Certificate("###.json")
firebase_admin.initialize_app(cred, {
                              'storageBucket': '###.appspot.com'
                              })

application = Flask(__name__)
@application.route('/single', methods=['GET'])
def api_list():
    
    name = request.args.get("name")

    bucket = storage.bucket()
    blob = bucket.get_blob(name)
        print(blob)
        blob.download_to_filename("name.wav")

        speech_file = "name.wav"
            with open(speech_file, 'rb') as speech:
                speech_content = base64.b64encode(speech.read())
                    data = {
                        'audio': {
                            'content': speech_content.decode('UTF-8')
                                },
                                    'config': {
                                        'encoding': 'LINEAR16',
                                            'sampleRateHertz': 16000,
                                                'languageCode': 'en-US'
                                                }
                                                    }
                                                        headers = {'Content-type': 'application/json'}
                                                            api = requests.post(
                                                                                "https://speech.googleapis.com/v1/speech:recognize?key=YOUR_GOOGLE_API_KEY",
                                                                                data=json.dumps(data), headers = headers)
                                                                
                                                                sentences = ""
                                                                    
                                                                    ###Parse
                                                                    for result in api.json()["results"]:
                                                                        if "alternatives" in result:
                                                                            alternatives = result["alternatives"][0]
                                                                            if "transcript" in alternatives and alternatives["confidence"] < 0.8:
                                                                                if alternatives["transcript"][0] == " ":
                                                                                    alternatives["transcript"] = alternatives["transcript"][1:]
                                                                                        sentences += ("[" +alternatives["transcript"] + "]" + "." + " ")
                                                                                            else:
                                                                                                sentences += alternatives["transcript"] + "." + " "
                                                                                                    
                                                                                                    return jsonify(',', sentences), 200

if __name__ == '__main__':
    application.run(host='0.0.0.0', debug=True)

# Back end 
#### :microphone: :memo:

## API's used:
- Google Speech to Text :speech_balloon:
- Firebase :fire:
- Dropbox :mailbox:
- Flask :sake:
- Alamofire :boom:

## How does it work?
1. Take recording filename from GET request with Flask
2. Download file from Firebase (WAV)
3. Use Google Speech to Text
4. Upload parsed text file to Dropbox
5. Return file to front-end Swift with Alamofire

## Features
- Custom filenames 
- Unclear texts are checked
  ```python
  if confidence < 0.8:
    print("[" + example_string + "]")
  ```
- Uploaded to a cloud 

# Back end 
#### :microphone: :memo:

## API's used:
- Google Speech to Text 
- Firebase
- Dropbox
- Flask
- Alamofire

## How does it work?
1. Take recording filename from GET request with Flask
2. Download file from Firebase (WAV)
3. Use Google Speech to Text
4. Upload parsed text file to Dropbox
5. Return file to front-end Swift with Alamofire

# LISTN

**LISTN is an app designed to assist students with note-taking.**
## App Description
LISTN uses Google's speech recognition technology to help disabled students to get more out of their lectures.

Many students have difficulty hearing, difficulty paying attention, and difficulty remembering the content of lectures.
LISTN is a solution that allows any student to record a live lecture, and automatically transcribe the audio into readable text. The recorded text is then available for the student to read at any time, as well as being searchable.

## Design Elements With Accessibility in Mind
- Color palette is high contrast for those with vision impairment.
- Suitable for the colorblind as well as those with limited vision.
- The function to "tap anywhere" to start the recording is useful for both those with limited vision and motor control impairment.
- No animations on the app because some conditions cause motion sickness from these animations. The iPhone has an option to limit motion within apps, so we want folks who have this feature enabled to experience the app with its intended design.
- Distinguishing buttons. Our sign in button has a bold outline and bold font, plus high contrast.
- Design of the dictation page. We chose a cream background and black text, which is an ideal color palette for dyslexic students. This makes it comfortable for the eyes when reading a long transcription.
- Andika font, which is one of the most readable Google fonts for dyslexics due to the distiguished typography of the "b" and "d" letters, as well as the "a" and "e".
- Icons are easy to interpret, familiar, and high contrast.
This app will make a huge difference for students who have difficulty hearing, as they now have access to a resource that allows them to be able to read what was previously said.

**________________________________________________________________**

The Front-End folder contains the Swift code used to code the user-facing part of the App.

The Listn Design Folder contains all the image files used in the App

The Back-End folder contains the Python code that handles the transcription of audio. 

# Back end 
#### :microphone: :memo:

## API's used:
- Google Speech to Text :speech_balloon:
- Firebase :fire:
- Dropbox :mailbox:
- Flask :sake:

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


# Front end
## API's used:
- Alamofire :boom:
- Firebase :fire:

## Mockups
<img src="/mockups/P1.png" width="300">

## Struggles
- Google Speech API requires 1 channel audio @ 16bit. Finding the correct settings was a pain.

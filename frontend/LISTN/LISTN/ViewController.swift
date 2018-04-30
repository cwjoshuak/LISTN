//
//  ViewController.swift
//  LISTN
//
//  Created by Joshua Kuan on 28/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase
import Alamofire

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordingImage: UIImageView!
    var audioRecorder : AVAudioRecorder!
    let audioSession = AVAudioSession.sharedInstance()
    var isRecording = false
    
    @IBOutlet weak var recordButtonV: UIButton!
    
    let fileManager = FileManager.default
    let GSURL = "gs://lisn-e5d07.appspot.com"
    
    let defaults = UserDefaults.standard // for persistent user data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Recording Background"))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordButton(_ sender: UIButton) {
        if(audioSession.recordPermission() != .granted) {
            let alert = UIAlertController(title: "Permission Denied", message: "LISN needs permission to access your microphone to record audio.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(!isRecording) {
            startRecording(fn: "filename")
            isRecording = true
            recordingImage.image = #imageLiteral(resourceName: "Dictation")
            recordingLabel.text = "Listening..."
        }
        else {
            isRecording = false
            finishRecording(success: true)
            recordingImage.image = #imageLiteral(resourceName: "Loading")
            recordingLabel.text = "Letting the ink dry.\nThis may take a minute..."
            uploadToServer()
        }
    }
    
    func uploadToServer() {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        concurrentQueue.async {
            let concurrentQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
            
            concurrentQueue.sync {
                let storage = Storage.storage(url: self.GSURL)
                let storageRef = storage.reference()
                
                let documentsURL = self.fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
                do {
                    let fileURLs = try self.fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
                    for i in fileURLs {
                        // File located on disk
                        let localFile = i.absoluteURL
                        
                        // Create a reference to the file you want to upload
                        let uploadReference = storageRef.child(i.lastPathComponent)
                        print(uploadReference)
                        // Upload the file to the path "somefile.(ext)"
                        let uploadTask = uploadReference.putFile(from: localFile, metadata: nil) { metadata, error in
                            if let error = error {
                                print(error)
                            } else {
                                if(i.lastPathComponent != ".DS_Store")
                                {
                                    // Create a reference to the file you want to download
                                    let downloadRef = storageRef.child(i.lastPathComponent)
                                    // Fetch the download URL
                                    downloadRef.downloadURL { url, error in
                                        if let error = error {
                                            print(error)
                                        } else {
                                            // print("https://respectfuldullwebsites--five-nine.repl.co/?param="+downloadRef.name)
                                            Alamofire.request("https://respectfuldullwebsites--five-nine.repl.co/single?name="+downloadRef.name).responseJSON { response in
                                                print("Request: \(String(describing: response.request))")   // original url request
                                                print("Response: \(String(describing: response.response))") // http url response
                                                print("Result: \(response.result)")                         // response serialization result
                                                
                                                if let json = response.result.value {
                                                    print("JSON: \(json)") // serialized json response
                                                }
                                                
                                                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                                    //let barControllers = self.tabBarController?.viewControllers
                                                    //let svc = barControllers?[1] as! TranscriptionVC
                                                    //svc.textField!.text = utf8Text
                                                    let tbvc = self.tabBarController as! IntermediaryTBControllerViewController
                                                    let newText = utf8Text.replacingOccurrences(of: "\"", with: "", options: NSString.CompareOptions.literal, range: nil)
                                                    tbvc.necessaryText = newText
                                                    print(newText)
                                                    print("Data: \(utf8Text)") // original server data as UTF8 string
                                                    
                                                    self.recordingImage.image = #imageLiteral(resourceName: "Oval")
                                                    self.recordingLabel.text = "Tap anywhere..."
                                                }
                                            }
                                            print(url?.absoluteString)
                                            print(downloadRef.name)
                                        }
                                    }
                            }
                        }
                        }
                    }
                } catch {
                    print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
                }
            }
        }
    }
    
    func startRecording(fn: String) {
        let audioFilename = getDocumentsDirectory()
            .appendingPathComponent(fn+".wav")
        
        let settings = [
            
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVLinearPCMBitDepthKey: 16,
            AVLinearPCMIsFloatKey: false,
            AVLinearPCMIsBigEndianKey: false,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ] as [String:Any]
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            print(audioFilename.absoluteString)
            audioRecorder.delegate = self
            audioRecorder.record()
            print("recording started")
        } catch {
            finishRecording(success: false)
        }
    }

    func finishRecording(success: Bool) {
        audioRecorder.stop()
        
        if success {
            print("recording finished")
        } else {
            print("recording failed")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for:
            .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}


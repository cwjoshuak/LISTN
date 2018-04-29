//
//  ViewController.swift
//  LISTN
//
//  Created by Joshua Kuan on 28/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder : AVAudioRecorder!
    let audioSession = AVAudioSession.sharedInstance()
    var isRecording = false
    
    @IBOutlet weak var recordButtonV: UIButton!
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
            recordButtonV.setTitle("Stop", for: .normal)
            recordButtonV.backgroundColor = UIColor.green
        }
        else {
            isRecording = false
            finishRecording(success: true)
            recordButtonV.setTitle("Record", for: .normal)
            recordButtonV.backgroundColor = UIColor.red
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


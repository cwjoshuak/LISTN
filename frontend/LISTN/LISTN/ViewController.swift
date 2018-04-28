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
    var isRecording = false
    
    @IBOutlet weak var recordButtonV: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func recordButton(_ sender: UIButton) {
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
            .appendingPathComponent(fn+".m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
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


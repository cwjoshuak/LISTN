//
//  TestViewController.swift
//  LISTN
//
//  Created by Joshua Kuan on 28/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit
import Firebase
class TestViewController: UIViewController {
    
    let fileManager = FileManager.default
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        label.text = "" // clear label
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
            for i in fileURLs {
                print(i.absoluteString)
                label.text = label.text! + i.absoluteString + "\n"
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        
        let storage = Storage.storage(url: "gs://lisn-e5d07.appspot.com")
        let storageRef = storage.reference()
        
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
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
                        
                    }
                }
                // Create a reference to the file you want to download
                if(i.lastPathComponent != ".DS_Store")
                {
                    let downloadRef = storageRef.child(i.lastPathComponent)
                    
                    // Fetch the download URL
                    downloadRef.downloadURL { url, error in
                        if let error = error {
                            print(error)
                        } else {
                            print(url?.absoluteString)
                        }
                    }
                }
            }
        } catch {
            print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
        }
        
    }
    func uploadToServer() {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

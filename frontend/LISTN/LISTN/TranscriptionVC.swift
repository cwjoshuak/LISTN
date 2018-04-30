//
//  TranscriptionVC.swift
//  LISTN
//
//  Created by Joshua Kuan on 29/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit

class TranscriptionVC: UIViewController {
    @IBOutlet weak var titleField: UILabel!
    
    @IBOutlet weak var dateField: UILabel!
    
    @IBOutlet weak var textField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let tbvc = self.tabBarController as! IntermediaryTBControllerViewController
        textField.text = tbvc.necessaryText
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
        dateField.text = timestamp
        view.backgroundColor = UIColor(red: 1.0, green: (235/255.0), blue: (221/255.0), alpha: 1.0)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        let tbvc = self.tabBarController as! IntermediaryTBControllerViewController
        textField.text = tbvc.necessaryText
        print(animated)
    }
    @IBOutlet weak var magnifyButton: UIBarButtonItem!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var exportButton: UIBarButtonItem!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

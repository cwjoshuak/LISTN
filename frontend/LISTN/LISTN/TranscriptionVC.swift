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
        
        // below is probably pretty bad programming style.
        //populate the textfield with the transcripted text
        let tbvc = self.tabBarController as! IntermediaryTBControllerViewController
        textField.text = tbvc.necessaryText
        
        // sets timestamp to today's date and time
        let timestamp = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.short)
        dateField.text = timestamp
        
        // changes bg color
        view.backgroundColor = UIColor(red: 1.0, green: (235/255.0), blue: (221/255.0), alpha: 1.0)
        
    }

    // on viewDidAppear, populate the textfield with the transcripted text
    // probably very bad programming style, HEADS UP!
    override func viewDidAppear(_ animated: Bool) {
        let tbvc = self.tabBarController as! IntermediaryTBControllerViewController
        textField.text = tbvc.necessaryText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // these buttons don't have functionality yet
    @IBAction func editButton(_ sender: UIBarButtonItem) {
    }
    // also i think i wired up these buttons wrongly..
    @IBOutlet weak var exportButton: UIBarButtonItem!
    @IBOutlet weak var magnifyButton: UIBarButtonItem!
}

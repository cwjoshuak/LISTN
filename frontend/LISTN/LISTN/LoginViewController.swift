//
//  LoginViewController.swift
//  LISTN
//
//  Created by Joshua Kuan on 28/04/2018.
//  Copyright © 2018 Joshua Kuan. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @objc override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Sign In Background"))
        
        // sets the cornered borders and backgroundColor of emailField
        emailField.layer.cornerRadius = 10.0
        emailField.layer.borderWidth = 2.0
        emailField.backgroundColor = UIColor(red: 1.0, green: CGFloat(235.0/255.0), blue: CGFloat(221/255.0), alpha: 1)
        
        // sets the cornered borders and backgroundColor of passwordField
        passwordField.layer.cornerRadius = 10.0
        passwordField.layer.borderWidth = 2.0
        passwordField.backgroundColor = UIColor(red: 1.0, green: CGFloat(235.0/255.0), blue: CGFloat(221/255.0), alpha: 1)
        
        // adds a listener which pushes down the keyboard when you tap outside any field (on the background)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        // make sure email and pw are not nil
        guard let email = emailField.text, let pw = passwordField.text else { return }
        
        // signs in
        Auth.auth().signIn(withEmail: email, password: pw) { (user, error) in
            if let error = error{
                // console log error and show user alert prompt
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                // if login successful, move to next vc
                self.performSegue(withIdentifier: "segueToMain", sender: self)
            }
        }
    }

}

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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        guard let email = emailField.text, let pw = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: pw) { (user, error) in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "segueToMain", sender: self)
            }
        }
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        guard let email = emailField.text, let pw = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: pw) { (user, error) in
            if let error = error{
                print(error)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "segueToMain", sender: self)
            }
        }
    }

}

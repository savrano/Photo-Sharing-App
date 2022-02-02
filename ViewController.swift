//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 1.02.2022.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "You got an error. Try again later.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            errorMessage(titleInput: "Error!", messageInput: "Please Enter Email and pasword. ")
        }
        
    }
    @IBAction func signupButtonPressed(_ sender: UIButton) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            //kayıt olma işlemi
            Auth.auth().createUser(withEmail: usernameTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error!", messageInput: error?.localizedDescription ?? "You got an error. Try Again.")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            errorMessage(titleInput: "Error!", messageInput: "Please Enter Email and pasword. ")
        }
    }
    
    func errorMessage(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
    }
}


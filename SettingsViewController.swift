//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 2.02.2022.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("User is not found.")
        }
        
    }
    
}

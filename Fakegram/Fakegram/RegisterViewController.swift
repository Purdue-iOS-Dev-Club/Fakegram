//
//  RegisterViewController.swift
//  Fakegram
//
//  Created by Siraj Zaneer on 10/24/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var passwordCField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let email = emailField.text!
        let password = passwordField.text!
        let passwordC = passwordCField.text!
        
        if password != passwordC {
            print("Passwords are wrong!")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                print("Yay we registered a user!" + user.email!)
                // Add user's information to database!
                var userData: [String: Any] = [:]
                userData["name"] = self.nameField.text!
                let userDoc = Firestore.firestore().collection("users").document(user.uid)
                userDoc.setData(userData, completion: { (error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                })
                //self.dismiss(animated: true, completion: nil)
            }
        }
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

//
//  LoginVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/3/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if user != nil {
                print("Login Successful")
                self.performSegue(withIdentifier: "goToTableL", sender: self)
                
                
//                Auth.auth().ReauthenticateAndRetrieveData(with: credential: FIRAUTHCredential) { (result, error) in
//                    if error == nil  {
//                        self.userDefault.set(true, forKey: "userSignedIn")
//                        self.userDefault.synchronize()
//                        print(result.user.email)
//                    }
//                }
                
            }else{
                print("error!")
                let alert = UIAlertController(title: "Error logging in", message: "Email or Password may be incorrect", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

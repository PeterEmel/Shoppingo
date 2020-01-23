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
        Auth.auth().signIn(withEmail: emailTextField.text!, link: passwordTextField.text!) { (user, error) in
            if error != nil {
                print("error!")
                
//                Auth.auth().ReauthenticateAndRetrieveData(with: credential: FIRAUTHCredential) { (result, error) in
//                    if error == nil  {
//                        self.userDefault.set(true, forKey: "userSignedIn")
//                        self.userDefault.synchronize()
//                        print(result.user.email)
//                    }
//                }
                
            }else{
                print("Login Successful")
                self.performSegue(withIdentifier: "goToTableL", sender: self)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

//
//  RegisterVCViewController.swift
//  Shoppingo
//
//  Created by Peter Emel on 11/30/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class RegisterVCViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                print(error!)
            }else{
                print("Registeration Successful")
                self.performSegue(withIdentifier: "goToTableR", sender: self)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    


    /*func setupNavBar (){
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        //navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    } */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

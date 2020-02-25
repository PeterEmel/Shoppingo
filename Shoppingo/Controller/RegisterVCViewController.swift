//
//  RegisterVCViewController.swift
//  Shoppingo
//
//  Created by Peter Emel on 11/30/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class RegisterVC: UIViewController {

    //Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobileNumTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    
    //Variables
    let alert = UIAlertController(title: "Empty Field(s)", message: "Please fill all the fields.", preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default) { (action) in
    }
    
    var ref : DatabaseReference!
    //var userResult : AuthDataResult!
    //let defaults = UserDefaults.standard
    
    var realm = try! Realm()
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        alert.addAction(action)
        
        guard let firstName : String = firstNameTextField.text else {return}
        guard let lastName : String = lastNameTextField.text else {return}
        guard let email : String = emailTextField.text else {return}
        guard let password : String = passwordTextField.text else {return}
        guard let adress : String = adressTextField.text else {return}
        guard let mobileNum : String = mobileNumTextField.text else {return}
        
        if (firstName == "" || lastName == "" || email == "" || password == "" || adress == "" || mobileNum == ""){
            present(alert, animated: true)
        }else{
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error!)
                }else{
                    print("Registeration Successful")
                    
                    let userData = ["firstName":firstName, "lastName":lastName, "email":email, "adress":adress, "mobileNum":mobileNum]
                    
                    self.ref.child("users").child((user?.user.uid)!).setValue(userData)
                    
                    
                    self.performSegue(withIdentifier: "goToTableR", sender: self)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }

}

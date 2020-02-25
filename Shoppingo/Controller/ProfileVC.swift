//
//  ProfileVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 2/19/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

class ProfileVC: UIViewController, UITextFieldDelegate {
  
    //Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var MobileNumTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    //Variables
    var emptyCart : CartVC?
    var ref : DatabaseReference!
    var registerVCObj : RegisterVC!
    let realm = try! Realm()
    let userID = Auth.auth().currentUser?.uid
    
    var firstName : String? {didSet{firstNameTextField.text=firstName}}
    var lastName : String?  {didSet{lastNameTextField.text=lastName}}
    var mobileNum : String? {didSet{MobileNumTextField.text=mobileNum}}
    var adress : String? {didSet{adressTextField.text=adress}}
    var email : String? {didSet{emailTextField.text=email}}
    
    var editingField : String = ""
    var fieldValue : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.firstNameTextField.delegate = self
        //let userAuth = UserDefaults.standard.data(forKey: "userAuth")
        self.ref = Database.database().reference()
        
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.MobileNumTextField.delegate = self
        self.adressTextField.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterVC.handleTap))
        view.addGestureRecognizer(tap)
    }
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
        disableFields()
        fetchUserData()
        //setTextFields()
        
    }
    func fetchUserData() {
        //let userID = Auth.auth().currentUser?.uid
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            
            self.firstName = value!["firstName"] as? String ?? ""
            self.lastName = value!["lastName"] as? String ?? ""
            self.email = value!["email"] as? String ?? ""
            self.mobileNum = value!["mobileNum"] as? String ?? ""
            self.adress = value!["adress"] as? String ?? ""
            
            print(self.firstName)
            print("Last Name: \(self.lastName)")
            
        }
    }
   
    func disableFields() {
        firstNameTextField.isEnabled = false
        firstNameTextField.backgroundColor = UIColor.lightGray
        
        
        lastNameTextField.isEnabled = false
        lastNameTextField.backgroundColor = UIColor.lightGray
        
        MobileNumTextField.isEnabled = false
        MobileNumTextField.backgroundColor = UIColor.lightGray
        
        adressTextField.isEnabled = false
        adressTextField.backgroundColor = UIColor.lightGray
        
        emailTextField.isEnabled = false
        emailTextField.backgroundColor = UIColor.lightGray
    }
    
    
//    func setTextFields() {
//        self.firstNameTextField.text = self.firstName
//        self.lastNameTextField.text = self.lastName
//        self.MobileNumTextField.text = self.mobileNum
//        self.adressTextField.text = self.adress
//        self.emailTextField.text = self.email
//    }
    
    
    @IBAction func editPressed(_ sender: UIButton) {
        print(sender.tag)
        switch sender.tag {
        case 0:
            print("First name edit")
            editingField = "firstName"
            firstNameTextField.isEnabled = true
            firstNameTextField.backgroundColor = UIColor.white
        case 1:
            print("Last name edit")
            editingField = "lastName"
            lastNameTextField.isEnabled = true
            lastNameTextField.backgroundColor = UIColor.white
        case 2:
            editingField = "mobileNum"
            MobileNumTextField.isEnabled = true
            MobileNumTextField.backgroundColor = UIColor.white
        case 3:
            editingField = "adress"
            adressTextField.isEnabled = true
            adressTextField.backgroundColor = UIColor.white
        default:
            return
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Return Pressed")
        textField.resignFirstResponder()
        
        switch editingField {
        case "firstName":
            if firstNameTextField.text != "" {
                fieldValue = firstNameTextField.text!
                //self.ref.child("users").child(userID!).setValue(["firstName":fieldValue])
                self.ref.child("users/\(userID!)/firstName").setValue(fieldValue)
            }
        case "lastName":
            print("got in last name")
            if firstNameTextField.text != "" {
                fieldValue = lastNameTextField.text!
                self.ref.child("users/\(userID!)/lastName").setValue(fieldValue)
            }
        case "mobileNum":
            if MobileNumTextField.text != "" {
                fieldValue = MobileNumTextField.text!
                self.ref.child("users/\(userID!)/mobileNum").setValue(fieldValue)
            }
        case "adress":
            if adressTextField.text != "" {
                fieldValue = adressTextField.text!
                self.ref.child("users/\(userID!)/adress").setValue(fieldValue)
            }
        default:
            print("missed all casses")
        }
        
        textField.isEnabled = false
        textField.backgroundColor = UIColor.lightGray
        
        return true
    }

    
    
    @IBAction func signoutPressed(_ sender: UIButton) {
        print("Signout pressed")
        do{
            try Auth.auth().signOut()
            print("Signed out")
            if emptyCart?.cartItems != nil {
                do{
                    try realm.write {
                        realm.delete((emptyCart?.cartItems)!)
                    }
                }catch{
                    debugPrint("Error Removing cartItems: \(error)")
                }
            }
        }catch{
            debugPrint("Error signing out: \(error)")
        }
            print("Before Segue")
            self.performSegue(withIdentifier: "backToHome", sender: self)        
        
//        let vc = UIStoryboard(name: "Main", bundle: nil)
//        let Dvc = vc.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
//        self.navigationController?.pushViewController(Dvc!, animated: true)
        
    }
    
}

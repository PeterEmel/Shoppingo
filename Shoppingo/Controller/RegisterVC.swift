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
    
    //var profile : ProfileModel!
    let realm = try! Realm()
    //var profileInfo : Results<ProfileModel>!
    
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        alert.addAction(action)
        //guard let username = usernameTextField.text else {return}
        let firstName : String? = firstNameTextField.text
        let lastName : String? = lastNameTextField.text
        let email : String? = emailTextField.text
        let password : String? = passwordTextField.text
        let adress : String? = adressTextField.text
        let mobileNum : String? = mobileNumTextField.text
        
        if (firstName == "" || lastName == "" || email == "" || password == "" || adress == "" || mobileNum == ""){
            present(alert, animated: true)
        }else{
            Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
                if error != nil {
                    print(error!)
                }else{
                    print("Registeration Successful")
                    let profile = ProfileModel(firstName:self.firstName, lastName:lastName, email:email, mobileNum:mobileNum, adress:adress)
                    self.save(profileInfo: self.profile)
                    self.performSegue(withIdentifier: "goToTableR", sender: self)
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func save(profileInfo:ProfileModel) {
        do{
            try realm.write {
                realm.add(profileInfo)
            }
        }catch{
            print("Error saving info, \(error)")
        }
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

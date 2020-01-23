//
//  InfoVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 1/5/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class InfoVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var adressTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func checkoutPressed(_ sender: UIButton) {
        
        let alert = UIAlertController.init(title: "Empty Fields", message: "Please fill all the fields", preferredStyle: .alert)
        let action = UIAlertAction.init(title: "OK", style: .default) { (action) in
            
        }
        alert.addAction(action)
        
        let firstName : String? = firstnameTextField.text
        let lastName : String? = lastnameTextField.text
        let adress : String? = adressTextField.text
        let mobileNum : String? = mobileTextField.text

        
        if (firstName == "" || lastName == "" || adress == "" || mobileNum == ""){
            present(alert, animated: true)
            
        }else{
            Firestore.firestore().collection(BUYERS_REF).addDocument(data: [FIRST_NAME:firstName, LAST_NAME:lastName, ADRESS:adress, MOBILE_NUM:mobileNum]) {(error)in
                if let error = error {
                    debugPrint("Error Adding Document \(error)")
                }else{
                    print("Successed Adding Document")
                    self.performSegue(withIdentifier: "goToCalculations", sender: self)
                }
            }
        }

    }



}

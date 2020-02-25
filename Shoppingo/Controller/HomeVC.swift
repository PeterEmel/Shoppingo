//
//  ViewController.swift
//  Shoppingo
//
//  Created by Peter Emel on 11/30/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UIViewController {

    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func LoginPressed(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //showApp()
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.3679437339, green: 0.621170342, blue: 0.7574153543, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    override func viewWillAppear(_ animated: Bool) {
        //showApp()
        self.navigationController?.isNavigationBarHidden = true
    }
    func showApp() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "TableVC") as! TableVC
            present(viewController, animated: true, completion: nil)
        }
    }

    
}


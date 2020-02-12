//
//  AppManager.swift
//  Shoppingo
//
//  Created by Peter Emel on 2/11/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

class AppManager {
    static let shared = AppManager()
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var appContainer : AppContainerVC!
    
    private init() { }
    
    func showApp() {
        var viewController : UIViewController
        
        if Auth.auth().currentUser == nil {
            viewController = storyboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        }else{
            viewController = storyboard.instantiateViewController(withIdentifier: "TableVC") as! TableVC
        }
        appContainer.present(viewController, animated: true, completion: nil)
    }
    
    func logout() {
        try! Auth.auth().signOut()
        appContainer.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}

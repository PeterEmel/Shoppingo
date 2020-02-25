//
//  ProfileModel.swift
//  Shoppingo
//
//  Created by Peter Emel on 2/19/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileModel : Object {
    @objc dynamic var firstName : String = ""
    @objc dynamic var lastName : String = ""
    @objc dynamic var email : String = ""
    @objc dynamic var mobileNum : String = ""
    @objc dynamic var adress : String = ""
    
//    init(firstName:String, lastName:String, email:String, mobileNum:String, adress:String) {
//        self.firstName = firstName
//        self.lastName = lastName
//        self.email = email
//        self.mobileNum = mobileNum
//        self.adress = adress
//    }
    
    convenience init(firstName:String, lastName:String, email:String, mobileNum:String, adress:String) {
        self.init()
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.mobileNum = mobileNum
        self.adress = adress
    }
    
}

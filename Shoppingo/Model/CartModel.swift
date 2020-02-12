//
//  CartModel.swift
//  Shoppingo
//
//  Created by Peter Emel on 2/1/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import Foundation
import RealmSwift

class Cart : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var productImageURL : String = ""
    @objc dynamic var price : Float = 0
}

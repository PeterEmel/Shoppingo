//
//  ItemsModel.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/26/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import Foundation
import Firebase

class Items {
    private(set) var title : String!
    private(set) var price : Double!
    private(set) var description : String!
    private(set) var url : String!

    init(title:String, price:Double, description:String, url:String) {
        self.title = title
        self.price = price
        self.description = description
        self.url = url
    }

    class func parsData(snapshot: QuerySnapshot?) -> [Items] {
        var itemsArray = [Items]()
        guard let snap = snapshot else{return itemsArray}
        for document in snap.documents {
            let data = document.data()
            let title = data[TITLE] as? String ?? "Anonymous"
            let price = data[PRICE] as? Double ?? 0
            let description = data[DESCRIPTION] as? String ?? ""
            let url = data[URL] as? String ?? "Can't get image"
            
            let newItem = Items(title: title, price: price, description: description, url: url)
            itemsArray.append(newItem)
        }
        return itemsArray
    }
}
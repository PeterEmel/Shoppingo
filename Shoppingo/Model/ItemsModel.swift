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
    private(set) var price : Float!
    private(set) var description : String!
    private(set) var productImage : UIImage!
    private(set) var image2 : UIImage!
    private(set) var url : String!

    init(title:String, price:Float, description:String, productImage:UIImage, image2:UIImage, url:String) {
        self.title = title
        self.price = price
        self.description = description
        self.productImage = productImage
        self.image2 = image2
        self.url = url
    }

    class func parsData(snapshot: QuerySnapshot?) -> [Items] {
        var documentsIdArray = [String]()
        
        var itemsArray = [Items]()
        guard let snap = snapshot else{return itemsArray}
        for document in snap.documents {
            let data = document.data()
            let title = data[TITLE] as? String ?? "Anonymous"
            let price = data[PRICE] as? Float ?? 0
            let description = data[DESCRIPTION] as? String ?? ""
            let url = data[URL] as? String ?? "Can't get image"
            let url2 = data[URL2] as? String ?? "Can't get image"
            let id = document.documentID
            print(id)
            
          
            for i in 0 ..< snap.documents.count {
                let dictData = snap.documents[i].data()
                let documentID = snap.documents[i].documentID
               // documentsIdArray.append(documentsIdArray)
                //print("Document Id: \(documentID)")
            }
            
            
            func requestImages(url:String) -> UIImage {
                var img : UIImage!
                if let url = Foundation.URL(string: url){
                    do{
                        let data = try Data(contentsOf: url)
                        img = UIImage(data: data)
                    }catch let err{
                        print("Error: \(err.localizedDescription)")
                    }
                }
                return img
            }
            let productImage = requestImages(url: url)
            let image2 = requestImages(url: url2)
            
            let newItem = Items(title: title, price: price, description: description, productImage: productImage, image2: image2, url: url)
            itemsArray.append(newItem)
        }
        return itemsArray
    }
}

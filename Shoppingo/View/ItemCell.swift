//
//  ItemCell.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/26/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import SDWebImage
import Alamofire

class ItemCell: UITableViewCell {
    
    //Variables
    static var items : Items!
    static var descArray = [String]()
    
    //Outlets
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
//    class func fetchImage(url:String, imagePlace: UIImageView) {
//        Alamofire.request(url).responseData { response in
//            debugPrint(response)
//
//            if let fetchedImage = response.result.value {
//                 imagePlace.image = UIImage.init(data: fetchedImage)
//
//            }
//        }
//    }
    

    func requestImages(img:String){
        if let url = Foundation.URL(string: img){
            do{
                let data = try Data(contentsOf: url)
                itemImage.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
    }
    
    
    func configureCell(items:Items){
        ItemCell.items = items

                
//        if let url = Foundation.URL(string: items.url){
//            do{
//            let data = try Data(contentsOf: url)
//                itemImage.image = UIImage(data: data)
//            }catch let err{
//                print("Error: \(err.localizedDescription)")
//            }
//        }
        
        //ItemCell.fetchImage(url: items.url, imagePlace: itemImage)
        requestImages(img: items.url)
        
        titleLbl.text = items.title

        priceLbl.text = String(items.price)
        
        ItemCell.descArray.append(items.description)
    }

}

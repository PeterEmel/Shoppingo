//
//  CartCell.swift
//  Shoppingo
//
//  Created by Peter Emel on 1/22/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import SwipeCellKit

class CartCell: SwipeTableViewCell {
    
    private var cartItems : Cart!
    
    //Outlets
    @IBOutlet weak var productImageView: UIImageView!
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
    
    func configureCartCell(cartItems:Cart){
        self.cartItems = cartItems
        
        //if let object = TableVC.staticobj {
            productImageView.image = requestImages(url: cartItems.productImageURL)
        
            titleLbl.text = cartItems.title
        
            priceLbl.text = String(cartItems.price)
        //}
        
    }

}

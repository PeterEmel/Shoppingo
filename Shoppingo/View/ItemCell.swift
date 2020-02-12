//
//  ItemCell.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/26/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Alamofire

class ItemCell: UITableViewCell {
    
    //Variables
    private var items : Items!
   // private var cartItems : Cart!
    
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
    
    
    func configureCell(items:Items){
        self.items = items


        itemImage.image = items.productImage
        
        titleLbl.text = items.title

        priceLbl.text = String(items.price)
        
    }
    
//    func configureCartCell(cartItems:Cart){
//        self.cartItems = cartItems
//
//
//        itemImage.image = cartItems.productImage
//
//        titleLbl.text = cartItems.title
//
//        priceLbl.text = String(cartItems.price)
//
//    }

}

//
//  ItemCell.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/26/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell: UITableViewCell {
    
    //Variables
    private var items : Items!

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

                
        if let url = Foundation.URL(string: items.url){
            do{
            let data = try Data(contentsOf: url)
                itemImage.image = UIImage(data: data)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
        titleLbl.text = items.title

        priceLbl.text = String(items.price)
        
    }
}

//
//  TableViewCell.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/5/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //override func setSelected(_ selected: Bool, animated: Bool) {
     //   super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    //}
    
}

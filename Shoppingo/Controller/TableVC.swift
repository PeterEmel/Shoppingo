//
//  TableVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/3/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase

struct CellData {
    let image : UIImage?
    let title : String?
}

class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data = [CellData]()
    
    @IBOutlet var shoppingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationItem .setHidesBackButton(true, animated: false)
        
        shoppingTableView.delegate = self
        shoppingTableView.dataSource = self
        
        
        shoppingTableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableViewCell")
        
        configureTableView()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        let titlesArray = ["First", "Second"]
        let pricesArray = ["10000", "20000"]
        
        cell.titleLabel.text = titlesArray[indexPath.row]
        cell.priceLabel.text = pricesArray[indexPath.row]
        
        
        return cell
    }
    
    
    func configureTableView(){
        shoppingTableView.rowHeight = UITableView.automaticDimension
        shoppingTableView.estimatedRowHeight = 500.0
    }
}

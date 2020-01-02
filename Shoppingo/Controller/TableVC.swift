//
//  TableVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 12/3/19.
//  Copyright © 2019 Peter Emel. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD


class TableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlets
    @IBOutlet var shoppingTableview: UITableView!
    
    //Variables
    private var itemsArray = [Items]()
    private var itemsCollectionRef : CollectionReference!
    private var itemsListener : ListenerRegistration!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        shoppingTableview.delegate = self
        shoppingTableview.dataSource = self
        
        
        shoppingTableview.rowHeight = UITableView.automaticDimension
        shoppingTableview.estimatedRowHeight = 160.0
        
        itemsCollectionRef = Firestore.firestore().collection(ITEMS_REF)
        

    }
    override func viewDidAppear(_ animated: Bool) {
        SVProgressHUD.show(withStatus: "Loading..")
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemCell {
            
            cell.configureCell(items: itemsArray[indexPath.row])
            
            return cell
        }else{
            return UITableViewCell()
        }
    }

    
    func setListener() {
        itemsListener = itemsCollectionRef.addSnapshotListener { (snapshot, error) in
            if let err = error {
                debugPrint("Error fetching docs: \(err)")
            }else{
                for document in (snapshot?.documents)!{
                    print(document.data())
                    }
                }
                self.itemsArray.removeAll()
                self.itemsArray = Items.parsData(snapshot: snapshot)
                self.shoppingTableview.reloadData()
            }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        setListener()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        itemsListener.remove()
        update()
    }
    @objc func update() {
        SVProgressHUD.dismiss()
    }
}

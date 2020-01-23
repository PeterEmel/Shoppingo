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
    private(set) var itemsArray = [Items]()
    private(set) var tempItemsArray = [Items]()
    private var itemsCollectionRef : CollectionReference!
    private var itemsListener : ListenerRegistration!
    //var yourObject : String!
    
    
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
                self.update()
                print("TRY THIS")
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let selectedItem = itemsArray[indexPath.row]
        
        let vc = UIStoryboard(name: "Main", bundle: nil)
        let Dvc = vc.instantiateViewController(withIdentifier: "DetailsVC") as? DetailsVC
        //Dvc?.getDescription = ItemCell.descArray[indexPath.row]
        Dvc?.getDescription = itemsArray[indexPath.row].description
        Dvc?.getUrl = itemsArray[indexPath.row].url
        Dvc?.getUrl2 = itemsArray[indexPath.row].url2
        
        self.navigationController?.pushViewController(Dvc!, animated: true)

       // performSegue(withIdentifier: "detailsVC", sender: nil)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        setListener()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        itemsListener.remove()
        //update()
    }
    @objc func update() {
        SVProgressHUD.dismiss()
    }
    @IBAction func unwindToTableVC(segue: UIStoryboardSegue){}
    
}
extension TableVC : UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Console hjfghj")
        guard let searchText = searchBar.text else{return}
        let titlesRef = Firestore.firestore().collection(ITEMS_REF)
        titlesRef.whereField("title", isGreaterThanOrEqualTo: searchText).whereField("title", isLessThanOrEqualTo: searchText+"z").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error Getting Doceument: \(err)")
            }else{
                for document in querySnapshot!.documents{
                    print("Documentd Data: \(document.data())")
                    self.tempItemsArray = self.itemsArray
                    self.itemsArray.removeAll()
                    self.itemsArray = Items.parsData(snapshot: querySnapshot)
                    self.shoppingTableview.reloadData()
                }
            }
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            
            itemsArray = tempItemsArray
            shoppingTableview.reloadData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

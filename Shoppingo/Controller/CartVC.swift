//
//  CartVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 1/22/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import RealmSwift
import SwipeCellKit

class CartVC: UITableViewController {
    
    //Variables
    var selectdItem : Items!
    var realm = try! Realm()
    var cartItems : Results<Cart>?
    
    var getImage : UIImage!
    var getTitle : String!
    var getPrice : Double!
    //var cartItems = [Items]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("Trial2: \(TableVC.staticobj.title!)")
        load()
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.cartDataChanged(_:)), name: NOTIF, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @objc func cartDataChanged(_ notif:Notification) {
        print("Entered")
        save(cartItem: changeItemsTOCart(item: TableVC.staticobj))
        tableView.reloadData()
        print(cartItems)
    }
    func addedToCart() {
        var isInCart = false
        if cartItems != nil {
            for i in cartItems! {
                if TableVC.staticobj.title == i.title {
                    isInCart = true
                }
            }
        }
        if isInCart == false {
            print("Entered")
            save(cartItem: changeItemsTOCart(item: TableVC.staticobj))
            tableView.reloadData()
        }
    }
    
    //Mark:- tableView Data Source
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as? CartCell {
            cell.delegate = self
            if let cart = cartItems {
                cell.configureCartCell(cartItems: cart[indexPath.row])
//                productImage.image = requestImages(url: cartItems![indexPath.row].productImageURL)
//                titleLbl.text = cartItems![indexPath.row].title
//                priceLbl.text = cartItems![indexPath.row].price
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    func save(cartItem:Cart) {
        do{
            try realm.write {
                realm.add(cartItem)
            }
        }catch{
            print("Error saving item, \(error)")
        }
    }
    func load() {
        cartItems = realm.objects(Cart.self)
    }
    
    func changeItemsTOCart(item:Items) -> Cart {
        let tempCart = Cart()
        tempCart.productImageURL = TableVC.staticobj.url
        tempCart.title = TableVC.staticobj.title
        tempCart.price = TableVC.staticobj.price
        
        return tempCart
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
    
}
extension CartVC : SwipeTableViewCellDelegate {
   
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.updateModel(at: indexPath)
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
       
        var options = SwipeOptions()
        //options.expansionStyle = .destructive(automaticallyDelete: false)
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
    func updateModel(at indexpath: IndexPath) {
        if let itemForDeletion = self.cartItems?[indexpath.row] {
            do{
                try self.realm.write {
                    self.realm.delete(itemForDeletion)
                }
            }catch{
                print("Error deleting item: \(error)")
            }
        }
    }
    
}

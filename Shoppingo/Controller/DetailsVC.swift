//
//  DetailsVC.swift
//  Shoppingo
//
//  Created by Peter Emel on 1/5/20.
//  Copyright © 2020 Peter Emel. All rights reserved.
//

import UIKit
import Alamofire
import ImageSlideshow

class DetailsVC: UIViewController {
    
    //Variables
    private var detItems : Items!
    private var imgArray = [UIImage]()
    var getDescription : String!
    var getProductImage : UIImage!
    var getImage2 : UIImage!
    
    //var isAddedToCart = false
    let cartObj = CartVC()
    
    
    //Outlets
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        configureDetails()
        scrollViewImages()
    
        
    }
    func scrollViewImages() {
        for i in 0..<imgArray.count {
            
            let imageView = UIImageView()
            imageView.image = imgArray[i]
            let xPosition = self.view.frame.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width:
                self.scrollView.frame.width + 50, height: self.scrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            
            scrollView.contentSize.width = scrollView.frame.width * CGFloat(i + 1)
            scrollView.addSubview(imageView)
            
        }

    }
    
    func configureDetails() {
        imgArray.append(getProductImage)
        imgArray.append(getImage2)
        descriptionLbl.text = getDescription
    }
    
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
        cartObj.addedToCart()
        //NotificationCenter.default.post(name: NOTIF, object: nil)
        let alert = UIAlertController.init(title: "", message: "Proceed to checkout or continue shopping", preferredStyle: .alert)
        let checkoutAction = UIAlertAction.init(title: "Checkout", style: .default) { (action1) in
            self.performSegue(withIdentifier: "goToCart", sender: self)
        }
        let continueAction = UIAlertAction.init(title: "Continue", style: .default) { (action2) in
            //self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "unwindToTableVC", sender: self)
        }
        alert.addAction(checkoutAction)
        alert.addAction(continueAction)
        
        present(alert,animated: true)
    }
    

    
}



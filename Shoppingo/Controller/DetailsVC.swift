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
import ATGMediaBrowser


class DetailsVC: UIViewController {
    
    
    //Variables
    private var detItems : Items!
    //private var itemCell : ItemCell!
    private var imgArray = [UIImage]()
    var getDescription : String!
    var getUrl : String!
    var getUrl2 : String!
  
    
    //Outlets
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        requestImages(url: getUrl)
        requestImages(url: getUrl2)
        descriptionLbl.text = getDescription
    }
    
    func requestImages(url:String){
        if let url = Foundation.URL(string: url){
            do{
                let data = try Data(contentsOf: url)
                let img = UIImage(data: data)
                imgArray.append(img!)
            }catch let err{
                print("Error: \(err.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func addToCartPressed(_ sender: UIButton) {
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



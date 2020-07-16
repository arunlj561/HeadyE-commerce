//
//  ProductDetailViewController.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    
    
class func productsDetailViewController(forProduct product:Products) -> ProductDetailViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController
        productDetailsViewController?.product = product
        return productDetailsViewController
    }
    @IBOutlet weak var giftRegisterButton: UIButton!
    
    var product:Products!
    var datasource = ProductDetailDatasource()
    
    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cartCount: UILabel!
    var count :Int!{
        didSet{
            if count > 0 {
                cartCount.isHidden = false
                cartCount.text = "\(count ?? 0)"
            }else{
                cartCount.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datasource.product = product
        tableView.dataSource = datasource
        self.navTitle.text = product.name
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
    }
    


}

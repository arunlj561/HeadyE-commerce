//
//  ProductListViewController.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit



class ProductListViewController: UIViewController{
    
    class func productsListViewController(forCategory category:Categories) -> ProductListViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productListViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController
        productListViewController?.categories = category
        productListViewController?.categoryId = category.id
        productListViewController?.title = category.name
        
        
        
        return productListViewController
    }
    
    
    
    @IBOutlet weak var emptyMessage: UILabel!
    
    var categories:Categories!
    var categoryId: Int64!
    var datasource = ProductDatasource()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
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

        self.categoryTitle.text = self.title
        self.datasource.categoryId = categoryId
        self.collectionView.delegate = self
        self.collectionView.dataSource = datasource
        
        if categories.products.count > 0 {
            self.collectionView.isHidden = false
        }else{
            self.collectionView.isHidden = true
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    }
    
    
    
    
    

}

extension ProductListViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: deviceWidth - 40, height: 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let product = datasource.fetchedResultsController.fetchedObjects?.first?.products{
            let selected = product[product.index(product.startIndex, offsetBy: indexPath.row)]
            if let productViewController = ProductDetailViewController.productsDetailViewController(forProduct: selected){
                        self.navigationController?.pushViewController(productViewController, animated: true)
                }
        }
        
        
        
    }
    
        
    
}


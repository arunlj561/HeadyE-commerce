//
//  ProductListViewController.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
enum ListType{
    case normal
    case viewed
    case order
    case shared
}


class ProductListViewController: UIViewController{
    
    class func productsListViewController(forCategory category:Categories?, listType:ListType) -> ProductListViewController?{
        let storyboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let productListViewController = storyboard.instantiateViewController(withIdentifier: "ProductListViewController") as? ProductListViewController
        productListViewController?.categories = category
        productListViewController?.listType = listType
        return productListViewController
    }
    
    
    
    @IBOutlet weak var emptyMessage: UILabel!
    
    var categories:Categories!
    var categoryId: Int64!
    var datasource = ProductDatasource()
    var productDatasource = ProductFilterDatasource()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var cartCount: UILabel!
    var listType:ListType!
    
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
        switch listType {
            case .normal:
                self.categoryTitle.text = categories.name
                self.datasource.categoryId = categories.id
                self.collectionView.delegate = self
                self.collectionView.dataSource = datasource
            if categories.products.count > 0 {
                self.collectionView.isHidden = false
            }else{
                self.collectionView.isHidden = true
            }
        case .order:
                self.categoryTitle.text = "Most Ordered Products"
                self.collectionView.delegate = self
                productDatasource.listType = .order
                self.collectionView.dataSource = productDatasource
        case .viewed:
                self.categoryTitle.text = "Most Viewed Products"
                self.collectionView.delegate = self
                productDatasource.listType = .viewed
                self.collectionView.dataSource = productDatasource
                
        case .shared:
            self.categoryTitle.text = "Most Shared Products"
            self.collectionView.delegate = self
                productDatasource.listType = .shared
            self.collectionView.dataSource = productDatasource
        default:
            break
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
        if listType == .normal{
            if let product = datasource.fetchedResultsController.fetchedObjects?.first?.products{
                let selected = product[product.index(product.startIndex, offsetBy: indexPath.row)]
                if let productViewController = ProductDetailViewController.productsDetailViewController(forProduct: selected){
                            self.navigationController?.pushViewController(productViewController, animated: true)
                    }
            }
        }else{
            let product = productDatasource.fetchedResultsController.object(at: indexPath)
            if let productViewController = ProductDetailViewController.productsDetailViewController(forProduct: product){
                            self.navigationController?.pushViewController(productViewController, animated: true)
                    }
            }
        
    }
    
        
    
}


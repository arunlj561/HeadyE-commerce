//
//  HomeViewController.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, RefreshViews {
    
    

    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    var datasource = CategoryDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                        
        if UserDefaults.standard.getFirstLoad() == false{
            ServiceManager.sharedInstance.getUserData { (result) in
                UserDefaults.standard.setFirsLoad()
            }
        }
        self.setupCollectionView()
    }
    
    func setupCollectionView(){
        self.navTitle.text = "Home"
        datasource.delegate = self
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
    
    func deleteRows(forindexPath indexPath: IndexPath) {
        
    }
    
    func updateRows(forindexPath indexPath: IndexPath) {
        
    }
    
    func insertRows(forindexPath indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }

}
extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: deviceWidth - 20, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = datasource.fetchedResultsController.object(at: indexPath)
        
        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: category){
            self.navigationController?.pushViewController(productsListViewController, animated: true)
        }
    }
}

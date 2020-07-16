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
    @IBAction func filterOption(_ sender: Any) {
        showOptions()
    }
    
    func showOptions(){
        let actionSheet = UIAlertController(title: "Ranking", message: "Filter by rankinng", preferredStyle: .actionSheet)
        let mostViewed = UIAlertAction(title: "Most Viewed Products", style: .default) { (action) in
            if let productsListViewController = ProductListViewController.productsListViewController(forCategory: nil, listType: .viewed){
                self.navigationController?.pushViewController(productsListViewController, animated: true)
            }
        }
        let mostOrdered = UIAlertAction(title: "Most Ordered Products", style: .default) { (action) in
            if let productsListViewController = ProductListViewController.productsListViewController(forCategory: nil, listType: .order){
                self.navigationController?.pushViewController(productsListViewController, animated: true)
            }
        }
        let mostShared = UIAlertAction(title: "Most Shared Products", style: .default) { (action) in
            if let productsListViewController = ProductListViewController.productsListViewController(forCategory: nil, listType: .shared){
                self.navigationController?.pushViewController(productsListViewController, animated: true)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                   
        }
        actionSheet.addAction(mostViewed)
        actionSheet.addAction(mostOrdered)
        actionSheet.addAction(mostShared)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}
extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: deviceWidth - 20, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = datasource.fetchedResultsController.object(at: indexPath)
        
        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: category, listType: .normal){
            self.navigationController?.pushViewController(productsListViewController, animated: true)
        }
    }
}

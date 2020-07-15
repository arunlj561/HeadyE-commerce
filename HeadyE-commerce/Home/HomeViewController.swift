//
//  HomeViewController.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navTitle: UILabel!
    @IBOutlet weak var collectionView:UICollectionView!
    var datasource = CategoryDatasource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ServiceManager.sharedInstance.getUserData { (result) in
         
        }
        self.setupCollectionView()
    }
    
    func setupCollectionView(){
        self.navTitle.text = "Home"
        collectionView.dataSource = datasource
        collectionView.delegate = self
    }
    


}
extension HomeViewController:UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: deviceWidth - 20, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = datasource.fetchedResultsController.object(at: indexPath)
//        if let productsListViewController = ProductListViewController.productsListViewController(forCategory: category, loadList: .normal){
//            self.navigationController?.pushViewController(productsListViewController, animated: true)
//        }
    }
}

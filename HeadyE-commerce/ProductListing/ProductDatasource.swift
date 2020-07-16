//
//  ProductDatasource.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData
class ProductDatasource: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
        
    var categoryId:Int64!
    
    var _fetchedResultsController: NSFetchedResultsController<Categories>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Categories>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                
        let predicate = NSPredicate(format: "id == \(categoryId!)")
        
        
        fetchRequest.predicate = predicate
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let category = self.fetchedResultsController.fetchedObjects?.first{
            return category.products.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        if let category = self.fetchedResultsController.fetchedObjects?.first{
            let products = category.products
            cell.configure(cellWith: products[products.index(products.startIndex, offsetBy: indexPath.row)])
        }
        
        
        return cell
    }
}

class ProductFilterDatasource: NSObject, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
        
    
    var listType:ListType!
    
    var _fetchedResultsController: NSFetchedResultsController<Products>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.persistentContainer.viewContext
    
    var fetchedResultsController: NSFetchedResultsController<Products>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()

        switch listType {
            case .order:
                let sortDescriptor = NSSortDescriptor(key: "orderCount", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                let predicate = NSPredicate(format: "orderCount != 0")
                fetchRequest.predicate = predicate
            case .shared:
                let sortDescriptor = NSSortDescriptor(key: "shareCount", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                let predicate = NSPredicate(format: "shareCount != 0")
                fetchRequest.predicate = predicate
            case .viewed:
                let sortDescriptor = NSSortDescriptor(key: "viewCount", ascending: false)
                fetchRequest.sortDescriptors = [sortDescriptor]
                let predicate = NSPredicate(format: "viewCount != 0")
                fetchRequest.predicate = predicate
        default:
              break
        }
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
                
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return _fetchedResultsController!
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.reuseIdentifier, for: indexPath) as! ProductCollectionViewCell
        
        let products = self.fetchedResultsController.object(at: indexPath)
        cell.configure(cellWith: products)
        
        
        
        return cell
    }
}


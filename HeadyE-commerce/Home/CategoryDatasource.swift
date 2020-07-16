//
//  CategoryDatasource.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

protocol RefreshViews:class {
    func deleteRows(forindexPath indexPath:IndexPath)
    func updateRows(forindexPath indexPath:IndexPath)
    func insertRows(forindexPath indexPath:IndexPath)
}


class CategoryDatasource: NSObject, UICollectionViewDataSource {
    
    var _fetchedResultsController: NSFetchedResultsController<Categories>? = nil
    var managedObjectContext :NSManagedObjectContext = CoreDataManager.persistentContainer.viewContext
    
    weak var delegate:RefreshViews?
    
    var fetchedResultsController: NSFetchedResultsController<Categories>
    {
    
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Categories> = Categories.fetchRequest()
                        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
                
        let predicate = NSPredicate(format: "id != 0")
        
        
//        fetchRequest.predicate = predicate
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        
        
        let category = self.fetchedResultsController.object(at: indexPath)
        cell.configure(cellWith: category)
        return cell
        
    }
    
}

extension CategoryDatasource:NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
            case .delete:
                if let deleteIndex = indexPath{
                    delegate?.deleteRows(forindexPath: deleteIndex)
                }
            case .update:
                if let updateIndex = indexPath{
                    delegate?.updateRows(forindexPath: updateIndex)
                }
            case .insert:
                if let insertIndex = newIndexPath{
                    delegate?.insertRows(forindexPath: insertIndex)
                }
            default:
                break
        }
    }
    
}

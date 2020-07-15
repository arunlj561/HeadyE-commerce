//
//  Products.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 14/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import CoreData

class Products:NSManagedObject,Codable{
    
    enum CodingKeys: String, CodingKey {
        case name
        case id
        case date_added
        case variants
        case tax
    }
    
    @NSManaged var name:String?
    @NSManaged var date_added:Date?
    var id:Int64?
    var shareCount:Int64?
    var viewCount:Int64?
    var orderCount:Int64?
    @NSManaged var variants:Set<Variants>?
    @NSManaged var tax:Tax?
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Products", in: managedObjectContext) else {
            fatalError("Failed to decode proudcts")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        let dateString = try container.decodeIfPresent(String.self, forKey: .date_added)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.date_added = dateFormatter.date(from: dateString ?? "")
        if let variant  =  try container.decodeIfPresent([Variants].self, forKey: .variants){
            var tempSet = Set<Variants>()
            for v in variant{
                tempSet.insert(v)
            }
            self.variants = tempSet
        }
        self.shareCount = 0
        self.orderCount = 0
        self.viewCount = 0
        self.tax = try container.decodeIfPresent(Tax.self, forKey: .tax)
        
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(id, forKey: .id)
        try container.encode(date_added, forKey: .date_added)
        try container.encode(variants, forKey: .variants)
        try container.encode(tax, forKey: .tax)
    }
    
    class func fetchRequest() -> NSFetchRequest<Products> {
        return NSFetchRequest<Products>(entityName: "Products")
    }

    
    class func updateViewCount(_ ranking:Rankings){
        if let product = ranking.products{
            for i in product{
                if let id = i.id{
                    let context = CoreDataManager.persistentContainer.viewContext
                    let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                    do {
                        let result = try context.fetch(fetchRequest)
                        if let product = result.first{
                            product.viewCount = Int64(i.view_count ?? 0)
                        }
                        CoreDataManager.saveContext()
                    } catch {
                        print("Could not fetch product")
                    }
                }
            }
        }
    }
    
    class func updateOrderCount(_ ranking:Rankings){
        if let product = ranking.products{
            for i in product{
                if let id = i.id{
                    let context = CoreDataManager.persistentContainer.viewContext
                    let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                    do {
                        let result = try context.fetch(fetchRequest)
                        if let product = result.first{
                            product.orderCount = Int64(i.order_count ?? 0)
                        }
                        CoreDataManager.saveContext()
                    } catch {
                        print("Could not fetch product")
                    }
                }
            }
        }
    }
    
    class func updateShareCount(_ ranking:Rankings){
        if let product = ranking.products{
            for i in product{
                if let id = i.id{
                    let context = CoreDataManager.persistentContainer.viewContext
                    let fetchRequest: NSFetchRequest<Products> = Products.fetchRequest()
                    fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                    do {
                        let result = try context.fetch(fetchRequest)
                        if let product = result.first{
                            product.shareCount = Int64(i.shares ?? 0)
                        }
                        CoreDataManager.saveContext()
                    } catch {
                        print("Could not fetch product")
                    }
                }
            }
        }
    }

}

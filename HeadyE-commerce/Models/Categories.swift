//
//  Categories.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 14/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import CoreData

class Categories: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case products
        case child_categories
    }
    
    var id :Int64?
    @NSManaged var name:String?
    @NSManaged var products:Set<Products>
    @NSManaged var child_categories:[Int64]?
    
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Categories", in: managedObjectContext) else {
            fatalError("Failed to decode categories")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        
        if let products = try container.decodeIfPresent([Products].self, forKey: .products){
            var tempSet = Set<Products>()
            for p in products{
                tempSet.insert(p)
            }
            self.products = tempSet
        }
        self.child_categories = try container.decodeIfPresent([Int64].self, forKey: .child_categories)
        
    }
    
    

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(child_categories, forKey: .child_categories)
        try container.encode(name, forKey: .name)
        try container.encode(products, forKey: .products)
    }
    
    class func fetchRequest() -> NSFetchRequest<Categories> {
        return NSFetchRequest<Categories>(entityName: "Categories")
    }
}

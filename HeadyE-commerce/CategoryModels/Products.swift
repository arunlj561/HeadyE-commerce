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

}

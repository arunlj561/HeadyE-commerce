//
//  Variants.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//


import CoreData
class Variants: NSManagedObject, Codable {
 
    enum CodingKeys: String, CodingKey {
        case color
        case id
        case size
        case price
    }
    
    @NSManaged var color:String?
    var id:Int64?
    var size:Int64?
    var price:Int64?
    
    
    // MARK: - Decodable
    required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Variants", in: managedObjectContext) else {
            fatalError("Failed to decode variants")
        }

        self.init(entity: entity, insertInto: managedObjectContext)

        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decodeIfPresent(Int64.self, forKey: .id)
        self.price = try container.decodeIfPresent(Int64.self, forKey: .price)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        self.size = try container.decodeIfPresent(Int64.self, forKey: .size)
        
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(color, forKey: .color)
        try container.encode(price, forKey: .price)
        try container.encode(size, forKey: .size)
    }
}

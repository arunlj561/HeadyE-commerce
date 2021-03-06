//
//  Variants.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//


import CoreData
import  UIKit
class Variants: NSManagedObject, Codable {
 
    enum CodingKeys: String, CodingKey {
        case color
        case id
        case size
        case price
    }
    
    @NSManaged var color:String?
    var id:Int64?{
        get {
            willAccessValue(forKey: "id")
            defer { didAccessValue(forKey: "id") }

            return primitiveValue(forKey: "id") as? Int64
        }
        set {
            willChangeValue(forKey: "id")
            defer { didChangeValue(forKey: "id") }

            guard let value = newValue else {
                setPrimitiveValue(nil, forKey: "id")
                return
            }
            setPrimitiveValue(value, forKey: "id")
        }

    }
    
    @NSManaged var size:NSNumber?
    @NSManaged var price:NSNumber?
    
    func getColor() -> UIColor{
        if let color = color{
            switch color {
            case "Red": return .red
            case "Blue" : return .blue
            case "Black" : return .black
            case "White": return .white
            case "Yellow" : return .yellow
            case "Grey" : return .gray
            case "Green" : return .green
            case "Brown" : return .brown
            case "Silver" : return .lightText
            case "Golden" : return UIColor(red: 252.0/255.0, green: 194.0/255.0, blue: 0, alpha: 1.0)
            case "Light Blue" : return UIColor.blue.withAlphaComponent(0.5)
            default:
                return .brown
            }
        }
        return .brown
    }
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
        
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
        
        if let _price = try container.decodeIfPresent(Int64.self, forKey: .price){
            self.price = NSNumber(value: _price)
        }
        
        
        if let _size = try container.decodeIfPresent(Int64.self, forKey: .size){
            self.size =  NSNumber(value: _size)
        }
        
    }

    // MARK: - Encodable
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(color, forKey: .color)
        let _price = price?.int64Value
        try container.encode(_price, forKey: .price)
        let _size = size?.int64Value
        try container.encode(_size, forKey: .size)
    }
}

//
//  Root.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import CoreData

struct Root:Codable {
    var categories:[Categories]?
    var rankings:[Rankings]?
}

struct Rankings:Codable {
    var ranking:String
    var products:[ProductType]?
}

struct ProductType:Codable {
    var id:Int?
    var view_count:Int?
    var order_count:Int?
    var shares:Int?
}

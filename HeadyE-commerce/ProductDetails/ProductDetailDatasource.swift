//
//  ProductDetailDatasource.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
enum RowType{
    case name
    case color
    case detail
    
    var reuseIdentifier:String!{
        switch self {        
        case .name : return "name"
        case .color: return "color"
        case .detail: return "detail"
        }
    }

    static let all:[RowType] = [ .name, .color, .detail]
}


class ProductDetailDatasource: NSObject,UITableViewDataSource {
    
    var rowDatasource = RowType.all
    var product:Products!
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return rowDatasource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = rowDatasource[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        cell.product = self.product
        switch type {
        case .detail: break
        case .name: cell.updateName()
            break
        case .color:
            cell.updateColorVariant(color: Array(product.variants ?? Set<Variants>()))
        
        }
    
        return cell
    }

}

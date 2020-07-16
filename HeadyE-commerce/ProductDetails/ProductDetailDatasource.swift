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
    
    
    var reuseIdentifier:String!{
        switch self {        
        case .name : return "name"
        }
    }

    static let all:[RowType] = [ .name]
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
        
        case .name: cell.updateName()
        
        
            
        
        }
    
        return cell
    }

}

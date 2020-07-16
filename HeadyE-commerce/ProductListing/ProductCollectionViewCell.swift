//
//  ProductCollectionViewCell.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    var product:Products!
    
    func configure(cellWith product:Products){
        self.product = product
        title.text = product.name
    
    }
    
    

}

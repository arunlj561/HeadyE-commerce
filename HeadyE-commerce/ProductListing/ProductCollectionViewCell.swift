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
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var orderedCount: UILabel!    
    @IBOutlet weak var shareCount: UILabel!
    
    var product:Products!
    
    func configure(cellWith product:Products){
        self.product = product
        title.text = product.name
        viewCount.text = "Viewed \(product.viewCount ?? 0)"
        orderedCount.text = "Ordered \(product.orderCount ?? 0)"
        shareCount.text = "Shared \(product.shareCount ?? 0)"
    }
    
    

}

//
//  DetailTableViewCell.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit


class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var wishList: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var product:Products!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var reviews: UILabel!
    
    @IBOutlet var colorVariantCollection: [UIButton]!
    
    var selectedVariant:Variants?
        
    
        
    
    
    @IBOutlet weak var content: UILabel!
    
    func updateName(){
        self.name.text = product.name
        if let variant = self.selectedVariant{
            price.text = "₹ \(variant.price ?? 0)"
            rating.text = "\(variant.size ?? 0)"
        }else{
            self.selectedVariant = product.variants?.first
        }
        
        
    }
    
    
    func updateContent(with detailContent:String) {
        if detailContent.count > 0{
            content.text = detailContent
        }else{
            content.text = "No details for this product"
        }
    }
    
    func updateColorVariant(color variant:[Variants]){                
        for (index, i) in variant.enumerated(){
            colorVariantCollection[index].isHidden = false
            if selectedVariant == i{
                
            }
        }
        
    }
    
    @IBAction func actionChangeVariant(_ sender: UIButton) {
        if let variants = product.variants{
//            selectedVariant = variants[variants.index(variants.startIndex, offsetBy: sender.tag)]
        }
        
    }
    
    
}

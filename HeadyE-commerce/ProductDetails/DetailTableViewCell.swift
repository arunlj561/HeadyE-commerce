//
//  DetailTableViewCell.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit


class DetailTableViewCell: UITableViewCell {
        
    var product:Products!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    @IBOutlet weak var size: UILabel!
    @IBOutlet var colorVariantCollection: [UIButton]!
    
    var selectedVariant:Variants?{
        didSet{
            if let variant = self.selectedVariant{
                price.text = "₹ \(variant.price ?? 0)"
                if let s = variant.size, s.intValue > 0{
                    size.isHidden = false
                    size.text = "Size - \(s)"
                }else{
                    size.isHidden = true
                }
                
            }
        }
    }
    
    func updateName(){
        self.name.text = product.name
        self.selectedVariant = product.variants?.first
        self.updateColorVariant(color: Array(product.variants ?? Set<Variants>()))
    }
    
    func updateColorVariant(color variant:[Variants]){
        for (index, i) in variant.enumerated(){
            colorVariantCollection[index].isHidden = false
            colorVariantCollection[index].backgroundColor = i.getColor()
            if i == selectedVariant{
                self.updateButton(index)
            }
        }
        
    }
    
    func updateButton(_ i : Int){
        for (index, btn) in colorVariantCollection.enumerated(){
            if i == index{
                btn.layer.borderColor = UIColor.lightGray.cgColor
                btn.layer.borderWidth = 4
            }else{
                btn.layer.borderColor = UIColor.lightGray.cgColor
                btn.layer.borderWidth = 0
            }
        }
        
    }
    
    
    @IBAction func actionChangeVariant(_ sender: UIButton) {
        if let variants = product.variants{
            selectedVariant = variants[variants.index(variants.startIndex, offsetBy: sender.tag)]
            self.updateButton(sender.tag)
            
        }
        
    }
    
    
}

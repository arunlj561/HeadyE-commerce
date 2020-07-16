//
//  UIViewCell+Extension.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 15/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
extension UITableViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class var reuseIdentifier : String {
        return "\(self)"
    }
}

var deviceWidth:CGFloat{
    return UIScreen.main.bounds.width
}

var deviceHeight:CGFloat{
    return UIScreen.main.bounds.height
}

extension UIViewController{
    @IBAction func pushBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}

extension UserDefaults{
    static let firstLoad = "firstLoad"
    
    func getFirstLoad() -> Bool{
        return UserDefaults.standard.bool(forKey: UserDefaults.firstLoad)
    }
    func setFirsLoad(){
        UserDefaults.standard.set(true, forKey: UserDefaults.firstLoad)
    }
}

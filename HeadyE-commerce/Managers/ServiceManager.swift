//
//  ServiceManager.swift
//  HeadyE-commerce
//
//  Created by Arun Jangid on 14/07/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit
import Alamofire
public enum ServiceResult<T> {
    case failure(Error)
    case success(T)
}

fileprivate enum ServiceParamType{
    case products(String)
    
    var path:String{
        switch self {
            case .products(let base): return base + "/json"
        }
    }
    
    
    
}


class ServiceManager {
    let baseUrl = "​https://stark-spire-93433.herokuapp.com"
    static let sharedInstance = ServiceManager()
    
    private init() {
    }
    
    
    func getUserData(_ completion:@escaping((ServiceResult<Bool>) -> Void)){
        let feedParam = ServiceParamType.products(baseUrl)
        var str = feedParam.path
        guard let url = URL(string: "https://stark-spire-93433.herokuapp.com/json") else{
            return
        }

        
        AF.request(url, method: .get ,encoding: JSONEncoding.default).responseData(completionHandler: { (response) in
            if let error = response.error {
                completion(.failure(response.error as! Error))
                return
            }
            guard let responseData = response.data else{
                return
            }
                        
            let responseStrInISOLatin = String(data: responseData, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
                    fatalError("Failed to retrieve managed object context")
                }
                
                // Parse JSON data
                let managedObjectContext = CoreDataManager.persistentContainer.viewContext
                let decoder = JSONDecoder()
                decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
                let root = try decoder.decode(Root.self, from: modifiedDataInUTF8Format)
                try managedObjectContext.save()
                
                if let rankings = root.rankings{
                    for i in rankings{
                        if i.ranking.contains("Viewed"){
                            Products.updateViewCount(i)
                        }else if i.ranking.contains("OrdeRed"){
                            Products.updateOrderCount(i)
                        }else if i.ranking.contains("ShaRed"){
                            Products.updateShareCount(i)
                        }
                    }
                }
                completion(.success(true))
            } catch (let exception){
                print(exception.localizedDescription)
                completion(.failure(exception))
            }
            
        })
    }
    
    
}

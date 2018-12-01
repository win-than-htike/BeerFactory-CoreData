
//
//  NetworkManager.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    private init() {}
    
    private static var sharedNetworkManager: NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    public static let shared : NetworkManager = {
        return sharedNetworkManager
    }()
    
    func getData(success : @escaping ([BeerVO]) -> Void, failure : @escaping (String) -> Void) {
        
        Alamofire.request("https://api.punkapi.com/v2/beers").responseJSON { (response) in
            
            let json = response.data
            
            if let json = json {
                do{
                    
                    let beerList = try JSONDecoder().decode([BeerVO].self, from: json)
                    success(beerList)
                    
                }catch let err{
                    print(err)
                    failure(err.localizedDescription)
                }
            } else {
                failure("Data is nil or empty.")
            }
            
        }
        
    }
    
}

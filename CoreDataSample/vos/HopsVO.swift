//
//  HopsVO.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class HopsVO: Codable {

    var name: String? = nil
    var add: String? = nil
    var attribute: String? = nil
    var id : String = UUID.init().uuidString
    
    enum CodingKeys: String, CodingKey {
        case name, add, attribute
    }
    
    
    public static func save(hopsList : [HopsVO], context : NSManagedObjectContext) -> [String] {
        
        var saveId = [String]()
        
        let entity = NSEntityDescription.entity(forEntityName: "Hops", in: context)
        
        hopsList.forEach { (hops) in
            
            let data = NSManagedObject(entity: entity!, insertInto: context)
            data.setValue(hops.id, forKey: "id")
            data.setValue(hops.add ?? "Unknow", forKey: "add")
            data.setValue(hops.name ?? "Unknow", forKey: "name")
            data.setValue(hops.attribute ?? "Unknow", forKey: "attribute")
            
            do {
                try context.save()
                saveId.append(hops.id)
            } catch {
                print("Failed saving")
            }
            
            
        }
        
        return saveId
        
    }
    
    public static func get(hopsIdList : [String], context : NSManagedObjectContext) -> [Hops] {
        
        var hopsList = [Hops]()
        
        // "["abc", "def", "gty"]"
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Hops")
        
        print("Printing data")
        for hopId in hopsIdList {
            
            print(hopId)
            
            if !hopId.isEmpty {
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", hopId)
                
                do {
                    
                    let result = try context.fetch(fetchRequest)
                    print("----\(result)")
                    if !result.isEmpty {
                        
                        if let data = result.first as! NSManagedObject as? Hops {
                            hopsList.append(data)
                        } else {
                            
                        }
                        
                    } else {
                        
                        print("Empty Result.")
                        
                    }
                    
                } catch let error {
                    print("Could not fetch. \(error), \(error.localizedDescription)")
                }
                
            } else {
                print("Empty Hops. ==> \(hopId)")
            }
            
        }
    
        return hopsList
        
    }
    
}

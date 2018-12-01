//
//  MaltsVO.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import CoreData

class MaltsVO: Codable {

    var name: String? = nil
    var id : String = UUID.init().uuidString
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public static func save(maltList : [MaltsVO], context : NSManagedObjectContext) -> [String] {
        
        var saveId = [String]()
        
        let entity = NSEntityDescription.entity(forEntityName: "Malt", in: context)
        
        maltList.forEach { (malt) in
            
            let data = NSManagedObject(entity: entity!, insertInto: context)
            data.setValue(malt.name ?? "Unknow", forKey: "name")
            data.setValue(malt.id, forKey: "id")
            
            do {
                try context.save()
                saveId.append(malt.id)
            } catch {
                print("Failed saving")
            }
            
        }
        
        return saveId
        
    }
    
    public static func get(maltIdList : [String], context : NSManagedObjectContext) -> [Malt] {
        
        var maltList = [Malt]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Malt")
        
        maltIdList.forEach { (maltId) in
            
            if !maltId.isEmpty {
                
                fetchRequest.predicate = NSPredicate(format: "id = %@", maltId)
                
                do {
                    
                    let result = try context.fetch(fetchRequest)
                    print("----\(result)")
                    if !result.isEmpty {
                        
                        if let data = result.first as! NSManagedObject as? Malt {
                            maltList.append(data)
                        } else {
                            
                        }
                        
                    } else {
                        
                        print("Empty Result.")
                        
                    }
                    
                } catch let error {
                    print("Could not fetch. \(error), \(error.localizedDescription)")
                }
                
            }
            
        }
        
        return maltList
        
    }
    
}

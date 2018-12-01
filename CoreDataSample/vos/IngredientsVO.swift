//
//  IngredientsVO.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import CoreData

class IngredientsVO: Codable {

    var id : String = UUID.init().uuidString
    var yeast: String? = nil
    var hops: [HopsVO]? = nil
    var malt: [MaltsVO]? = nil
    
    enum CodingKeys: String, CodingKey {
        case yeast, hops, malt
    }
    
    public static func save(ingredients : IngredientsVO, hopsId : [String], maltId : [String], context : NSManagedObjectContext) -> String {
        
        var saveId = ""
        
        let entity = NSEntityDescription.entity(forEntityName: "Ingredients", in: context)
        let data = NSManagedObject(entity: entity!, insertInto: context)
        data.setValue(ingredients.id, forKey: "id")
        data.setValue(ingredients.yeast, forKey: "yeast")
        data.setValue(hopsId, forKey: "hops_id")
        data.setValue(maltId, forKey: "malt_id")
        
        do {
            try context.save()
            saveId = ingredients.id
        } catch {
            print("Failed saving")
        }
        
        
        return saveId
        
    }
    
    public static func get(ingredientId : String, context : NSManagedObjectContext) -> Ingredients {
        
        var ingredient : Ingredients!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "Ingredients")
        
        fetchRequest.predicate = NSPredicate(format: "id = %@", ingredientId)
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            if !result.isEmpty {
                
                if let data = result.first as! NSManagedObject as? Ingredients {
                    ingredient = data
                } else {
                    ingredient = Ingredients(context: context)
                }
                
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return ingredient
        
    }
    
}

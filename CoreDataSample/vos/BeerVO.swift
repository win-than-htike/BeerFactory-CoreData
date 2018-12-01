//
//  BeerVO.swift
//  CoreDataSample
//
//  Created by Win Than Htike on 11/26/18.
//  Copyright © 2018 PADC. All rights reserved.
//

import UIKit
import CoreData

class BeerVO: Codable {
    
    var id: Int? = nil
    var name: String? = nil
    var tagline: String? = nil
    var firstBrewed: String? = nil
    var desc: String? = nil
    var imageUrl: String? = nil
    var ingredients : IngredientsVO? = nil
    
    enum CodingKeys: String, CodingKey {
        case id, name, tagline, ingredients
        case firstBrewed = "first_brewed"
        case desc = "description"
        case imageUrl = "image_url"
    }
    
    public static func save(beer : BeerVO, ingredientId : String, context : NSManagedObjectContext) -> Int? {
        
        let entity = NSEntityDescription.entity(forEntityName: "Beers", in: context)
        
        let data = NSManagedObject(entity: entity!, insertInto: context)
        data.setValue(String(beer.id ?? 0), forKey: "id")
        data.setValue(beer.name, forKey: "name")
        data.setValue(beer.tagline, forKey: "tagline")
        data.setValue(beer.desc, forKey: "desc")
        data.setValue(beer.imageUrl, forKey: "image_url")
        data.setValue(ingredientId, forKey: "ingredient_id")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        return beer.id
        
    }
    
    public static func get(context : NSManagedObjectContext) -> [Beers] {
        
        var beerList : [Beers] = []
        
        do {
            beerList = try context.fetch(Beers.fetchRequest())
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return beerList
        
    }

}

//
//  Beers+CoreDataProperties.swift
//  
//
//  Created by Win Than Htike on 11/27/18.
//
//

import Foundation
import CoreData


extension Beers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Beers> {
        return NSFetchRequest<Beers>(entityName: "Beers")
    }

    @NSManaged public var desc: String?
    @NSManaged public var first_brewed: String?
    @NSManaged public var id: String?
    @NSManaged public var image_url: String?
    @NSManaged public var ingredient_id: String?
    @NSManaged public var name: String?
    @NSManaged public var tagline: String?

}

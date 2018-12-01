//
//  Ingredients+CoreDataProperties.swift
//  
//
//  Created by Win Than Htike on 11/30/18.
//
//

import Foundation
import CoreData


extension Ingredients {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Ingredients> {
        return NSFetchRequest<Ingredients>(entityName: "Ingredients")
    }

    @NSManaged public var hops_id: [String]?
    @NSManaged public var id: String?
    @NSManaged public var malt_id: [String]?
    @NSManaged public var yeast: String?

}

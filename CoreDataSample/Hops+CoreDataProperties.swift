//
//  Hops+CoreDataProperties.swift
//  
//
//  Created by Win Than Htike on 11/26/18.
//
//

import Foundation
import CoreData


extension Hops {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hops> {
        return NSFetchRequest<Hops>(entityName: "Hops")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var add: String?
    @NSManaged public var attribute: String?

}

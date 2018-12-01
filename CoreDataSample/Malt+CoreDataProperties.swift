//
//  Malt+CoreDataProperties.swift
//  
//
//  Created by Win Than Htike on 11/26/18.
//
//

import Foundation
import CoreData


extension Malt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Malt> {
        return NSFetchRequest<Malt>(entityName: "Malt")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

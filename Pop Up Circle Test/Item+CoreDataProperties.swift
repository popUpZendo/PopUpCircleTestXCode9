//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Joseph Hall on 6/29/17.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<Item>(entityName: "Item") as! NSFetchRequest<NSFetchRequestResult>
    }

    @NSManaged public var created: Date?
    @NSManaged public var details: String?
    @NSManaged public var itemType: String?
    @NSManaged public var location: String?
    @NSManaged public var price: Double
    @NSManaged public var time: String?
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}

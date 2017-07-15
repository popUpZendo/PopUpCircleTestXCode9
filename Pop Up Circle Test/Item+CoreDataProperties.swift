//
//  Item+CoreDataProperties.swift
//  
//
//  Created by Joseph Hall on 7/14/17.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var bell: Bool
    @NSManaged public var created: NSDate?
    @NSManaged public var days: String?
    @NSManaged public var details: String?
    @NSManaged public var eventTime: NSDate?
    @NSManaged public var itemType: String?
    @NSManaged public var location: String?
    @NSManaged public var time: String?
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?

}

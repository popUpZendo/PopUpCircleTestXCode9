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
    @NSManaged public var eventTime: Date?
    @NSManaged public var friday: Bool
    @NSManaged public var itemType: String?
    @NSManaged public var location: String?
    @NSManaged public var monday: Bool
    @NSManaged public var saturday: Bool
    @NSManaged public var sunday: Bool
    @NSManaged public var thursday: Bool
    @NSManaged public var time: String?
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toItemType: ItemType?
    @NSManaged public var toStore: Store?
    @NSManaged public var tuesday: Bool
    @NSManaged public var wednesday: Bool

}

//extension CoreDataArrayObj {
//    var weekdays: [String] {
//        get {
//            return daysArray as? Array<String> ?? []
//        }
//        set {
//            daysArray = newValue as NSArray
//        }
//    }
//}


//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Jonny B on 8/16/16.
//  Copyright © 2016 Jonny B. All rights reserved.
//

import Foundation
import CoreData

extension ItemType {

    @nonobjc open override class func fetchRequest() -> NSFetchRequest<NSFetchRequestResult> {
        return NSFetchRequest<ItemType>(entityName: "ItemType") as! NSFetchRequest<NSFetchRequestResult>;
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}

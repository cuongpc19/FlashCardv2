//
//  Event+CoreDataProperties.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/14/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var thumbnail: NSObject?
    @NSManaged public var timestamp: NSDate?
    @NSManaged public var photo: Photo?
    @NSManaged public var record: Record?

}

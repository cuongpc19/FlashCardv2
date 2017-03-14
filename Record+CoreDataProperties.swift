//
//  Record+CoreDataProperties.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/14/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record");
    }

    @NSManaged public var record: NSData?
    @NSManaged public var event: Event?

}

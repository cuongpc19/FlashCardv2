//
//  Photo+CoreDataProperties.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/14/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo");
    }

    @NSManaged public var image: UIImage?
    @NSManaged public var event: Event?

}

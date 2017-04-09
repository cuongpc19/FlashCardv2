//
//  FallingObjectBehavior.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 4/8/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit

class FallingObjectBehavior: UIDynamicBehavior {
    private let gravity = UIGravityBehavior()
    private let collider : UICollisionBehavior = {
        let collider = UICollisionBehavior()
        collider.translatesReferenceBoundsIntoBoundary = true
        return collider
    }()
    private let itemBehavior : UIDynamicItemBehavior = {
        let dib = UIDynamicItemBehavior()
        dib.allowsRotation = true
        dib.elasticity = 0.6
        return dib
    }()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(itemBehavior)
    }
    func addItem (item: UIDynamicItem) {
        gravity.addItem(item)
        collider.addItem(item)
        itemBehavior.addItem(item)
    }
    func removeItem (item: UIDynamicItem) {
        gravity.removeItem(item)
        collider.removeItem(item)
        itemBehavior.removeItem(item)
    }
}

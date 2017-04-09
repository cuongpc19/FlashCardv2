//
//  Page1View.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 4/8/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit

class Page3View: UIView , UIDynamicAnimatorDelegate {
    
    var uiImage : UIImage?
    var uiImageTaptap = UIImageView(image: #imageLiteral(resourceName: "tapGesture"))
    private let dropBehavior = FallingObjectBehavior()
    var animating : Bool = false {
        didSet {
            if animating {
                animator.addBehavior(dropBehavior)
                
            } else {
                animator.removeBehavior(dropBehavior)
            }
        }
    }
   
    
    private lazy var animator : UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
    private let dropsPerRow = 1
    private var dropSize: CGSize {
        let size = bounds.size.width / CGFloat (dropsPerRow)
        return CGSize(width: size, height: size)
    }
    private var gestureImgSize: CGSize {
        let size = bounds.size.width / (CGFloat (dropsPerRow) * 3)
        return CGSize(width: size, height: size)
    }

    func addGestureImg() {
        var frameGesture = CGRect(center: bounds.mid, size: gestureImgSize)
        uiImageTaptap.frame = frameGesture
        addSubview(uiImageTaptap)
    }
    func addDrop() {
        var frame = CGRect(origin: CGPoint.zero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        let uiImg = UIImageView(image: self.uiImage)
        uiImg.frame = frame
        uiImg.layer.cornerRadius = uiImg.frame.size.width / 2
        uiImg.clipsToBounds = true
        uiImg.layer.borderColor = UIColor.random.cgColor
        uiImg.layer.borderWidth = 10.0
        addSubview(uiImg)
        dropBehavior.addItem(item: uiImg)
        uiImg.alpha = 0
        //add Img animation rollover
        //let top = CGAffineTransform(translationX: 0, y: -300)
        UIView.animate(withDuration: 3, delay: 0.5, options: .beginFromCurrentState, animations: {
          //  uiImg.transform = top
            uiImg.alpha = 1
        }, completion: nil)
        
        //gesture Newframe
        var newgestureImgSize: CGSize {
            let size = bounds.size.width / (CGFloat (dropsPerRow) * 9)
            return CGSize(width: size, height: size)
        }
        let newframeGesture = CGRect(origin: CGPoint.zero, size: newgestureImgSize)
        self.uiImageTaptap.frame = newframeGesture
        
        UIView.animate(withDuration: 2, delay: 1, options: [.beginFromCurrentState,.repeat], animations: {
            self.uiImageTaptap.frame.origin.x = 100
        }, completion: nil)
        
        
    }
    
   
    
    
    
   
}

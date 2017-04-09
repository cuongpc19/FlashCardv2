//
//  Page3ViewController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 4/8/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import AVFoundation
class Page3ViewController: DataViewController {

    private var tapGesture : Bool = false
    
    @IBOutlet weak var gameView: Page3View! {
        didSet {
                gameView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDrop(_:))))                        
        }
    }
    func addDrop(_ recognizer : UITapGestureRecognizer) {
        if ((recognizer.state == .ended) && (!tapGesture))  {
            if dataImage != nil
            {
                gameView.uiImage = dataImage
            }
            gameView.addDrop()
            tapGesture = true
            playRecord()
            
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gameView.addGestureImg()
        gameView.animating = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        gameView.animating = false
    }
    
    
    
    

}

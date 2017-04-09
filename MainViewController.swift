//
//  MainViewController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 4/9/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        registrationNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var corverButton: UIButton!

    @IBOutlet weak var sideMenuViewContainer: UIView!
    
    @IBOutlet weak var leftSideMenuConstraint: NSLayoutConstraint!
    
    var isSideMenuOpen: Bool = true {
        didSet {
            if isSideMenuOpen {
                configForSideMenuOpeningState()
            } else {
                configForSideMenuClosingState()
            }
            UIView.animate(withDuration: 0.35, animations: {
                self.view.layoutIfNeeded()
            }) { (isSuccess) in
                // TODO:
            }
        }
    }
    
    func configForSideMenuOpeningState() {
        leftSideMenuConstraint.constant = 0
        self.corverButton.alpha = 0.5
    }
    
    func configForSideMenuClosingState() {
        leftSideMenuConstraint.constant = -sideMenuViewContainer.bounds.width
        self.corverButton.alpha = 0
    }
    func registrationNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(onClickCorverButton), name: NotificationKey.key, object: nil)
    }
    
    @IBAction func onClickCorverButton(_ sender: Any) {
        isSideMenuOpen = !isSideMenuOpen
    }

}
struct NotificationKey {
    static let key = NSNotification.Name.init("MenuClick")
}

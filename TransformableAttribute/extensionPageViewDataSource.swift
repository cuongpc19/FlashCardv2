//
//  extensionPageViewDataSource.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/15/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
extension ModelController : UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        //print("currentIndex : \(index)")
        index -= 1
        //print("index in function - \(index)")
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        //print("currentIndex : \(index)")
        index += 1
        if index == self.pageData.count {
            //print("index in function + \(index) , self.pageData.count : \(self.pageData.count)")
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
}


//
//  ModelController.swift
//  TransformableAttribute
//
//  Created by AgribankCard on 3/15/17.
//  Copyright © 2017 cuongpc. All rights reserved.
//

import UIKit
import CoreData
class ModelController: NSObject {
    
    var pageData: [String] = []
    var managedObjectContext = CoreDataStack.sharedInstance.context
    var eventData : [Event] = []
    override init() {
        super.init()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(ModelController.actOnSpecialNotification), name: NSNotification.Name(rawValue: mySpecialNotificationKey), object: nil)
    }
    
    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? { 
        if (self.eventData.count == 0) || (index >= self.eventData.count) {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        let identifierController : String
        
        identifierController = NamePageViewController.page3.rawValue
        let dataViewController = storyboard.instantiateViewController(withIdentifier: identifierController) as! DataViewController
        dataViewController.dataObject = (self.eventData[index].timestamp?.description)!
        if let photo = eventData[index].photo {
            dataViewController.dataImage = photo.image
        }
        if let record = eventData[index].record {
            dataViewController.dataRecord = record
        }
        return dataViewController
    }
    
    func indexOfViewController(_ viewController: DataViewController) -> Int {
        return pageData.index(of: viewController.dataObject) ?? NSNotFound
    }
    
    func fetchData() {
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Event")
        //
        do {
            let results = try managedObjectContext.fetch(fetchRequest)
            eventData = results  as! [Event]
            for event in eventData {
                pageData.append((event.timestamp?.description)!)
            }
        } catch
            let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    //MARK: Notification
    func actOnSpecialNotification() {
        fetchData()
    }
    
}



//
//  DataManager.swift
//  Every.do
//
//  Created by Raman Singh on 2018-05-16.
//  Copyright © 2018 Raman Singh. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    var _fetchedResultsController: NSFetchedResultsController<ToDo>? = nil
    var myFetchedResultsController: NSFetchedResultsController<ToDo>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ToDo> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "toDoDescription", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }//fetchedResultsController
    
    func insertObject(title:String) {
        
        let context = myFetchedResultsController!.managedObjectContext
        let newToDo = ToDo(context: context)
        
        newToDo.toDoDescription = title
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }//insertObject
    
    
}//end

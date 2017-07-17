//
//  MainVC.swift
//  DreamLister
//
//  Created by Joseph Hall on 6/16/17.
//  Copyright © 2016 Joseph Hall. All rights reserved.
//

import UIKit
import CoreData

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isIdleTimerDisabled = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //generateTestData()
        attemptFetch()

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        configureCell(cell, indexPath: (indexPath as NSIndexPath) as IndexPath)
        return cell
    }
    
    func configureCell(_ cell: ItemCell, indexPath: IndexPath) {
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let objs = controller.fetchedObjects , objs.count > 0 {
            
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ItemDetailsVC" {
            if let destination = segue.destination as? ItemDetailsVC {
                if let item = sender as? Item {
                    destination.itemToEdit = item
                }
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sections = controller.sections {
            
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let sections = controller.sections {
            return sections.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        let scheduleSort = NSSortDescriptor(key: "time", ascending: true)
        //let scheduleSort2 = NSSortDescriptor(key: "time", ascending: true)
        let practiceSort = NSSortDescriptor(key: "itemType", ascending: true)
        
        if segment.selectedSegmentIndex == 0 {
            
            fetchRequest.sortDescriptors = [scheduleSort]
            let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
            //let predicateAM = NSPredicate(format: "time CONTAINS[c] %@", "AM")
            //let predicatePM = NSPredicate(format: "time CONTAINS[c] %@", "PM")
//            let predicate1 = NSPredicate(format: "time CONTAINS[c] %@", "AM")
//            let predicate2 = NSPredicate(format: "time CONTAINS[c] %@", "PM")
//            let compound: NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1 > predicate2])
            //self.filteredArray = self.array.filteredArrayUsingPredicate(compound)
            //self.table.reloadData()
           // fetchRequest.predicate = predicateAM || predicatePM
            
//            fetchRequest.sortDescriptors = [scheduleSort2]
//            let predicatePM = NSPredicate(format: "time CONTAINS[c] %@", "PM")
//            fetchRequest.predicate = predicatePM
            
//            fetchRequest.predicate = predicateAM
            fetchRequest.predicate = predicate1
            
        } else if segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [practiceSort]
            let predicate2 = NSPredicate(format: "itemType CONTAINS[c] %@", "Practice")
             fetchRequest.predicate = predicate2
            
        }         
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
            let count = try ad.persistentContainer.viewContext.count(for: fetchRequest)
            
            if count == 0 {
                
                generateTestData()
                
            }
            
            try controller.performFetch()
            
        } catch {
            
            let error = error as NSError
            print("\(error)")
            
        }
        
    }
    
    @IBAction func segmentChange(_ sender: AnyObject) {
        
        attemptFetch()
        tableView.reloadData()
        
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
            
        case.insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case.delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case.update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! ItemCell
                configureCell(cell, indexPath: (indexPath as NSIndexPath) as IndexPath)
            }
            break
        case.move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        
        }
    }
    
    func generateTestData() {
        
        let item = Item(context: context)
        item.title = "Zazen"
        item.location = "Home"
        item.details = "Morning Sit - 25 Minutes"
        item.time = "7:00 AM"
        item.bell = true
        item.itemType = "Schedule"
        
        let item2 = Item(context: context)
        item2.title = "Zen Driving"
        item2.location = "Car"
        item2.details = "Drive with attentive awareness.  Place the hands on the wheel and observe how the body/unconcious mind drives the car."
        item2.time = "8:00 AM"
        item2.bell = true
        item2.itemType = "Schedule"
        
        let item3 = Item(context: context)
        item3.title = "Mindful Lunch"
        item3.location = "Cafe"
        item3.details = "Eat in silence with rapt attention of every detail of the meal on the table, it taste, aroma, color and with awareness of the many beings through which it arose and opportunities that are created through this energy"
        item3.time = "12:00 PM"
        item3.bell = true
        item3.itemType = "Schedule"
        
        let item4 = Item(context: context)
        item4.title = "Loving Kindness Meditation"
        item4.location = "Work"
        item4.details = "Morning Sit - 25 Minutes"
        item4.time = "2:00 PM"
        item4.bell = true
        item4.itemType = "Schedule"
        
        let item5 = Item(context: context)
        item5.title = "Zazen"
        item5.location = "Home"
        item5.details = "Evening Sit - 15 Minutes"
        item5.time = "6:00 PM"
        item5.bell = true
        item5.itemType = "Schedule"
        
        let item6 = Item(context: context)
        item6.title = "Gratitude Pratice"
        item6.location = "Home"
        item6.details = "Before going to bed follow Brother David's gratitude practice"
        item6.time = "9:00 PM"
        item6.bell = true
        item6.itemType = "Schedule"
        
        let item7 = Item(context: context)
        item7.title = "Stop - Look -Go"
        item7.location = "Anywhere"
        item7.details = "Follow Brother David's gratitude practice"
        item6.time = ""
        item7.bell = false
        item7.itemType = "Practice"
        
        ad.saveContext()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

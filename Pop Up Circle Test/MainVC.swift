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

    @IBOutlet weak var menuBtn: UIButton!
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) { }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var controller: NSFetchedResultsController<Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()  .tapGestureRecognizer())
        UIApplication.shared.isIdleTimerDisabled = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
//generateTestData()
        // Test Data and real data are separate on sort
        
        attemptFetch()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true;
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
        
        let scheduleSort = NSSortDescriptor(key: "eventTime", ascending: true)
        
        let practiceSort = NSSortDescriptor(key: "itemType", ascending: true)
        
        let date = Date()
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateFormat = "dd-MM-yyyy"
        
        dateFormatter1.dateFormat = "EEEE"
        let currentDateString: String = dateFormatter1.string(from: date)
        print("today is \(currentDateString)")
        
        
        if segment.selectedSegmentIndex == 0 {
                
                switch currentDateString {
                    
                case "Sunday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "sunday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                case "Monday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "monday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                case "Tuesday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "tuesday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    //fetchRequest.predicate = predicate1
                    
                case "Wednesday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "wednesday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                case "Thursday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "thursday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                case "Friday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "friday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                case "Saturday":
                    
                    fetchRequest.sortDescriptors = [scheduleSort]
                    let predicate1 = NSPredicate(format: "itemType CONTAINS[c] %@", "Schedule")
                    let predicate3 = NSPredicate(format: "saturday == %@", NSNumber(booleanLiteral: true))
                    let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [predicate1, predicate3])
                    fetchRequest.predicate = andPredicate
                    
                default:
                    print("Today's date was not translated")
                }
            
            
        } else if segment.selectedSegmentIndex == 2 {
            
            fetchRequest.sortDescriptors = [practiceSort]
            let predicate2 = NSPredicate(format: "itemType CONTAINS[c] %@", "Practice")
             fetchRequest.predicate = predicate2
            
        } else if segment.selectedSegmentIndex == 1 {
            
            fetchRequest.sortDescriptors = [scheduleSort]
            fetchRequest.sortDescriptors = [practiceSort]
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
    
    

    
    ////////////////
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case UISwipeGestureRecognizerDirection.left:
                UIView.animate(withDuration: 0.1, animations: {
                    let myFrame = self.view.frame
                    self.view.frame = CGRect(-myFrame.size.width, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                }, completion: {_ in
                    let myFrame = self.view.frame
                    self.view.frame = CGRect(myFrame.size.width, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        let myFrame = self.view.frame
                        self.view.frame = CGRect(0.0, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                    }, completion: nil)
                })
                // do left action here
                
            case UISwipeGestureRecognizerDirection.right:
                UIView.animate(withDuration: 0.1, animations: {
                    let myFrame = self.view.frame
                    self.view.frame = CGRect(myFrame.size.width, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                }, completion: {_ in
                    let myFrame = self.view.frame
                    self.view.frame = CGRect(-myFrame.size.width, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                    
                    UIView.animate(withDuration: 0.3, animations: {
                        let myFrame = self.view.frame
                        self.view.frame = CGRect(0.0, myFrame.origin.y , myFrame.size.width, myFrame.size.height)
                    }, completion: nil)
                })
                // do right action here
                
            default:
                break
            }
        }
    }
    
    
    /////////////////
    func generateTestData() {
        
        let dateformatterToDate = DateFormatter()
        dateformatterToDate.dateFormat = "h:mm a"
        let Date1 = dateformatterToDate.date(from: "7:00 AM")
        let Date2 = dateformatterToDate.date(from: "8:00 AM")
        let Date3 = dateformatterToDate.date(from: "12:00 PM")
        let Date4 = dateformatterToDate.date(from: "2:00 PM")
        let Date5 = dateformatterToDate.date(from: "6:00 PM")
        let Date6 = dateformatterToDate.date(from: "9:00 PM")
        let Date7 = dateformatterToDate.date(from: "12:00 AM")
        let Date8 = dateformatterToDate.date(from: "12:00 AM")
        
        
        
        let item = Item(context: context)
        item.title = "Zazen"
        item.location = "Home"
        item.details = "Morning Sit - 25 Minutes"
        item.time = "7:00 AM"
        item.bell = true
        item.itemType = "Schedule"
        item.eventTime = Date1
        item.sunday = true
        item.monday = true
        item.tuesday = true
        item.wednesday = true
        item.thursday = true
        item.friday = true
        item.saturday = true
        
        let item2 = Item(context: context)
        item2.title = "Zen Driving"
        item2.location = "Car"
        item2.details = "Drive with attentive awareness.  Place the hands on the wheel and observe how the body/unconcious mind drives the car."
        item2.time = "8:00 AM"
        item2.bell = true
        item2.itemType = "Schedule"
        item2.eventTime = Date2
        item2.sunday = true
        item2.monday = true
        item2.tuesday = true
        item2.wednesday = true
        item2.thursday = true
        item2.friday = true
        item2.saturday = true
        
        let item3 = Item(context: context)
        item3.title = "Mindful Lunch"
        item3.location = "Cafe"
        item3.details = "Eat in silence with rapt attention of every detail of the meal on the table, it taste, aroma, color and with awareness of the many beings through which it arose and opportunities that are created through this energy"
        item3.time = "12:00 PM"
        item3.bell = true
        item3.itemType = "Schedule"
        item3.eventTime = Date3
        item3.sunday = true
        item3.monday = true
        item3.tuesday = true
        item3.wednesday = true
        item3.thursday = true
        item3.friday = true
        item3.saturday = true
        
        let item4 = Item(context: context)
        item4.title = "Loving Kindness Meditation"
        item4.location = "Work"
        item4.details = "Brief Instructions for Loving-Kindness Meditation \n To practice loving-kindness meditation, sit in a comfortable and relaxed manner. Take two or three deep breaths with slow, long and complete exhalations. Let go of any concerns or preoccupations. For a few minutes, feel or imagine the breath moving through the center of your chest - in the area of your heart. /n Metta is first practiced toward oneself, since we often have difficulty loving others without first loving ourselves. Sitting quietly, mentally repeat, slowly and steadily, the following or similar phrases: \n May I be happy. May I be well. May I be safe. May I be peaceful and at ease. \n While you say these phrases, allow yourself to sink into the intentions they express. Loving-kindness meditation consists primarily of connecting to the intention of wishing ourselves or others happiness. However, if feelings of warmth, friendliness, or love arise in the body or mind, connect to them, allowing them to grow as you repeat the phrases. As an aid to the meditation, you might hold an image of yourself in your mind's eye. This helps reinforce the intentions expressed in the phrases. \n After a period of directing loving-kindness toward yourself, bring to mind a friend or someone in your life who has deeply cared for you. Then slowly repeat phrases of loving-kindness toward them: \n May you be happy. May you be well. May you be safe. May you be peaceful and at ease. \n As you say these phrases, again sink into their intention or heartfelt meaning. And, if any feelings of loving-kindness arise, connect the feelings with the phrases so that the feelings may become stronger as you repeat the words. \nAs you continue the meditation, you can bring to mind other friends, neighbors, acquaintances, strangers, animals, and finally people with whom you have difficulty. You can either use the same phrases, repeating them again and again, or make up phrases that better represent the loving-kindness you feel toward these beings. In addition to simple and perhaps personal and creative forms of metta practice, there is a classic and systematic approach to metta as an intensive meditation practice. Because the classic meditation is fairly elaborate, it is usually undertaken during periods of intensive metta practice on retreat. \n Sometimes during loving-kindness meditation, seemingly opposite feelings such as anger, grief, or sadness may arise. Take these to be signs that your heart is softening, revealing what is held there. You can either shift to mindfulness practice or you can—with whatever patience, acceptance, and kindness you can muster for such feelings—direct loving-kindness toward them. Above all, remember that there is no need to judge yourself for having these feelings."
        item4.time = "2:00 PM"
        item4.bell = true
        item4.itemType = "Schedule"
        item4.eventTime = Date4
        item4.sunday = true
        item4.monday = true
        item4.tuesday = true
        item4.wednesday = true
        item4.thursday = true
        item4.friday = true
        item4.saturday = true
        
        let item5 = Item(context: context)
        item5.title = "Zazen"
        item5.location = "Home"
        item5.details = "Evening Sit - 15 Minutes"
        item5.time = "6:00 PM"
        item5.bell = true
        item5.itemType = "Schedule"
        item5.eventTime = Date5
        item5.sunday = true
        item5.monday = true
        item5.tuesday = true
        item5.wednesday = true
        item5.thursday = true
        item5.friday = true
        item5.saturday = true
        
        let item6 = Item(context: context)
        item6.title = "Gratitude Pratice"
        item6.location = "Home"
        item6.details = "Before going to bed, I glance back over the day and ask myself: Did I stop and allow myself to be surprised? Or, did I trudge on in a daze? Take this opportunity to feel the gratitude that is offered in each of these moments"
        item6.time = "9:00 PM"
        item6.bell = true
        item6.itemType = "Schedule"
        item6.eventTime = Date6
        item6.sunday = true
        item6.monday = true
        item6.tuesday = true
        item6.wednesday = true
        item6.thursday = true
        item6.friday = true
        item6.saturday = true
        
        let item7 = Item(context: context)
        item7.title = "Stop - Look -Go"
        item7.location = "Anywhere"
        item7.details = "When you are in practice, a split second is enough to stop. And then you look. What is, now, the opportunity of this given moment? Only this moment, the unique opportunity this moment gives? \n And that is where this beholding comes in.And if we really see what the opportunity is, we must, of course, not stop there, but we must do something with it. Go. Avail yourself of that opportunity. And if you do that, if you try practicing that at this moment, tonight, we would already be happier people, because it has an immediate feedback of joy. I always say not — I don’t speak of the gift, because not for everything that’s given to you can you really be grateful. You can’t be grateful for war in a given situation, or violence, or domestic violence, or sickness, things like that. There are many things for which you cannot be grateful. But in every moment, you can be grateful. For instance, the opportunity to learn something from a very difficult experience, what to grow by it, or even to protest, to stand up, and take a stand. That is a wonderful gift in a situation in which things are not the way they ought to be. So opportunity is really the key when people ask, can you be grateful for everything? No, not for everything, but in every moment."
        item7.time = ""
        item7.bell = false
        item7.itemType = "Practice"
        item7.eventTime = Date7
        item7.sunday = true
        item7.monday = true
        item7.tuesday = true
        item7.wednesday = true
        item7.thursday = true
        item7.friday = true
        item7.saturday = true
        
        let item8 = Item(context: context)
        item8.title = "A Few Notes"
        item8.location = "About this App"
        item8.details = "This is an early beta so expect a few bugs.  This app, at this stage, was created to help you design a neo-monastic practice. The five components of Zen Training are Meditation, Learning, and Intentional Practice.  Each of the three main screens focuses on a particular area and is designed to support you in your growth. Each day you make some kind of effort in each of this areas is a day of spiritual growth.  Curious where each button will lead you and the ways you will imagine to do things better.  Much is still in flux and there are more features to come.  One thing that I am still working with is the Schedule Button, which must be pushed twice in order to pull up the clock or to save.  In deep appreciation for your practice which was the inspiration that brought this into existance.  -Joe"
        item8.time = ""
        item8.bell = false
        item8.itemType = "Practice"
        item8.eventTime = Date8
        item8.sunday = true
        item8.monday = true
        item8.tuesday = true
        item8.wednesday = true
        item8.thursday = true
        item8.friday = true
        item8.saturday = true
        
        
        
        
        
        ad.saveContext()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}

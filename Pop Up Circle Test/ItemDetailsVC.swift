//
//  ItemDetailsVC.swift
//  PopUpZendo
//
//  Created by Joseph Hall on 6/19/17.
//  Copyright © 2017 Joseph Hall All rights reserved.


import UIKit
import CoreData
import DLRadioButton
import CHDayPicker
import UserNotifications



class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  

  
    @IBOutlet weak var bellSwitch: UISwitch!
    
    
    
    @IBOutlet weak var eventTimeValue: UILabel!
    @IBOutlet weak var bellValue: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dayPicker: CHDayPicker!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet var timePicker:UIDatePicker!
    @IBOutlet weak var dateTimeDisplay: UILabel!
    @IBOutlet weak var timeDisplay: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField1: CustomTextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var itemTypeField: CustomTextField!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var locationField: CustomTextField!
    
    @IBOutlet weak var toggleReminderButton: UIButton!
    
    
    
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var eventTimeCalc: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        //bellValue.text = "true"
        
        self.dayPicker.singleSelection = false
        self.dayPicker.delegate = self
        self.dayPicker.selectDayAtPosition(position: 1)
        self.dayPicker.selectDayAtPosition(position: 3)
        self.dayPicker.selectDayAtPosition(position: 5)
        
        itemTypeField.delegate = self
        timePicker.isHidden = true
        thumgImg.isHidden = true
        hideButton.isHidden = true
        
        titleField.delegate = self
        //detailsField.delegate = self
        itemTypeField.delegate = self
        
    
        
    self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ titleField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func detailsFieldShouldReturn(_ titleField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func itemTypeFieldShouldReturn(_ titleField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    var alarm = Bool ()
    
    @IBAction func switchChanged(_ sender: Any)
        
        {
            if bellSwitch.isOn {
                alarm = true
                print("true")
                bellValue.text = "true"
            }
            else {
                alarm = false
                print(false)
                bellValue.text = "false"
            }
        }
    
    func switchState() {
        if alarm == true {
            bellSwitch.setOn(true, animated: false)
        }else{
            bellSwitch.setOn(false, animated: false)}
    }
    
//    var onButtonSelection: (() -> ())?
//
//    @IBAction func remindButtonTapped(_ sender: Any) {
//        onButtonSelection?()
//    }
//
//    func showReminderOnIcon() {
//        toggleReminderButton.setImage(#imageLiteral(resourceName: "bell-button-1"), for: .normal)
//    }
//
//    func showReminderOffIcon() {
//        toggleReminderButton.setImage(#imageLiteral(resourceName: "bell-button-2"), for: .normal)
//    }
    
    @IBAction func timePickerChanged(_ sender: AnyObject) {
        setTime()
    }
    
    
    func setTime() {
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeDisplay.text = timeFormatter.string(from: timePicker.date)
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateTimeDisplay.text = dateTimeFormatter.string(from: timePicker.date)
        
    }
    
//    func setCoreTime()  {
//                let dateformatterToDate = DateFormatter()
//
//                dateformatterToDate.dateFormat = "h:mm a"
//
//                eventTimeCalc = dateformatterToDate.date(from: timeDisplay.text!)
//    }
    
    
    
    @IBAction func radioPractice(_ sender: Any) {
        hideButton.isHidden = false;
        thumgImg.isHidden = false;
        itemTypeField.text = "Practice"
    }
    
    @IBAction func radioSchedule(_ sender: Any) {
        hideButton.isHidden = true;
        timePicker.isHidden = false;
        itemTypeField.text = "Schedule"
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        
        var item: Item!
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        if itemToEdit == nil {
            
            item = Item(context: context)
            
        } else {
            
            item = itemToEdit
            
        }
        
         item.toImage = picture
        
         item.bell = alarm
        //print(alarm)
        print(item.bell)
        
        if let title = titleField.text {
            
            item.title = title
            //print(item.title)
            
        }
        
        if let itemType = itemTypeField.text {
            
            item.itemType = itemType
            
        }
        
        if let location = locationField.text {
            
            item.location = location
            
        }
        
        if let time = timeDisplay.text {
        
        item.time = time
        
        }
        
        if let eventTime = eventTimeCalc {
            
        item.eventTime = eventTime as NSDate
           // print(item.eventTime)
            
                    }
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        
        
//        var bell: Bool = false
//        if(bellValue.text = "true"){
//            return true
//        }
        
        
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
            timeDisplay.text = item.time
            titleField.text = item.title
            locationField.text = item.location
            alarm = item.bell
            detailsField.text = item.details
            itemTypeField.text = item.itemType
            thumgImg.image = item.toImage?.image as? UIImage
            //timePicker.date = item.eventTime
            //timePicker.date = (item.eventTime as! NSDate) as Date
            // I am nervous that this exclamation mark could cause crashing.
            func showCoreTime (){
                let dateformatterToString = DateFormatter()
                
                dateformatterToString.dateFormat = "h:mm a"
                
                eventTimeValue.text = dateformatterToString.string(from: item.eventTime! as Date)
            }
            
        }
        
    }
    
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        
        if itemToEdit != nil {
            context.delete(itemToEdit!)
            ad.saveContext()
        }
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    @IBAction func addImage(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        let content = UNMutableNotificationContent()
        content.title = titleField.text!
        //content.subtitle = "Let's see how smart you are!"
        content.body = detailsField.text
        content.sound = UNNotificationSound(named: "templeBell.mp3")
        //content.badge = 1
        //content.categoryIdentifier = "quizCategory"
        
        let dateString = "2017-04-04 019:41:00"
        let dateFormatter = DateFormatter()
        
        var localTimeZoneName: String { return TimeZone.current.identifier }
        var secondsFromGMT: Int { return TimeZone.current.secondsFromGMT() }
        dateFormatter.timeZone = TimeZone(secondsFromGMT: secondsFromGMT)
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateObj:Date = dateFormatter.date(from: dateString)!
        
        
        
        let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: dateObj)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        
        
        
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let deleteAction = UNNotificationAction(identifier: "UYLDeleteAction",
                                                title: "Delete", options: [.destructive])
        
        //let triggerWeekly = Calendar.current.dateComponents([.weekday,hour,.minute,.second,], from: date)
        //let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let requestIdentifier = "africaQuiz"
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            // handle error
        })
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}

extension ItemDetailsVC : CHDayPickerDelegate {
    func didSelectDay(position: Int, label: String, selected : Bool) {
        self.resultLabel.text = "\(position) : \(label)"
    }
}

extension ItemDetailsVC: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // some other way of handling notification
        completionHandler([.alert, .sound])
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
//        case "answerOne":
//            imageView.image = UIImage(named: "bell-button-1")
//        case "answerTwo":
//            imageView.image = UIImage(named: "bell-button-2")
        case "clue":
            let alert = UIAlertController(title: "Hint", message: "The answer is greater than 29", preferredStyle: .alert)
            let action = UIAlertAction(title: "Thanks!", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        default:
            break
        }
        completionHandler()
        
    }
}



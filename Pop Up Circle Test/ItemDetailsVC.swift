//
//  ItemDetailsVC.swift
//  PopUpZendo
//
//  Created by Joseph Hall on 6/19/17.
//  Copyright © 2017 Joseph Hall All rights reserved.


import UIKit
import CoreData
import DLRadioButton
//import CHDayPicker
import UserNotifications


class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  

  
    @IBOutlet weak var bellSwitch: UISwitch!
    
    @IBOutlet weak var eventTimeValue: UILabel!
    @IBOutlet weak var bellValue: UILabel!
//    @IBOutlet weak var resultLabel: UILabel!
//    @IBOutlet weak var dayPicker: CHDayPicker!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet var timePicker:UIDatePicker!
    @IBOutlet weak var dateTimeDisplay: UILabel!
    @IBOutlet weak var timeDisplay: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var itemTypeField: CustomTextField!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var locationField: CustomTextField!
    @IBOutlet weak var scheduleButton: DLRadioButton!
    @IBOutlet weak var practiceButton: DLRadioButton!
    @IBOutlet weak var toggleReminderButton: UIButton!
    
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    
    
    
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var eventTimeCalc: Date?
    
    var weekdays = ["s", "m", "t", "w", "t", "f", "s"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        //bellValue.text = "true"
        
//        self.dayPicker.singleSelection = false
//        self.dayPicker.delegate = self
//        self.dayPicker.selectDayAtPosition(position: 1)
//        self.dayPicker.selectDayAtPosition(position: 3)
//        self.dayPicker.selectDayAtPosition(position: 5)
        
//        if let didSelectDay(position: 0, label: "S", selected : true) {
//
//        }
        
        
        
//        print(self.dayPicker.daysLabel)
//
        
        
        
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
    
    
    @IBAction func timePickerChanged(_ sender: AnyObject) {
        setTime()
    }
    
    
    func setTime() {
        timeFormatter.timeStyle = DateFormatter.Style.short
        timeDisplay.text = timeFormatter.string(from: timePicker.date)
        
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateTimeDisplay.text = dateTimeFormatter.string(from: timePicker.date)
        
    }
    
    @IBAction func sundayPressed(_ sender: Any) {
        if sundayButton.isSelected == false {
            sundayButton.isSelected = true
            weekdays[0] = "sunday"
            print(weekdays)
        }else{
            sundayButton.isSelected = false
            weekdays[0] = "s"
            print(weekdays)
        }
        
    }
    
    @IBAction func mondayPressed(_ sender: Any) {
        if mondayButton.isSelected == false {
            mondayButton.isSelected = true
            weekdays[1] = "monday"
            print(weekdays)
        }else{
            mondayButton.isSelected = false
            weekdays[1] = "m"
            print(weekdays)
        }
    }
    
    @IBAction func tuesdayPressed(_ sender: Any) {
        if tuesdayButton.isSelected == false {
            tuesdayButton.isSelected = true
            weekdays[2] = "tuesday"
            print(weekdays)
        }else{
            tuesdayButton.isSelected = false
            weekdays[2] = "t"
            print(weekdays)
        }
    }
    
    @IBAction func wednesdayPressed(_ sender: Any) {
        if wednesdayButton.isSelected == false {
            wednesdayButton.isSelected = true
            weekdays[3] = "wednesday"
            print(weekdays)
        }else{
            wednesdayButton.isSelected = false
            weekdays[3] = "w"
            print(weekdays)
        }
    }
    
    @IBAction func thursdayPressed(_ sender: Any) {
        if thursdayButton.isSelected == false {
            thursdayButton.isSelected = true
            weekdays[4] = "thursday"
            print(weekdays)
        }else{
            thursdayButton.isSelected = false
            weekdays[4] = "t"
            print(weekdays)
        }
    }
    
    @IBAction func fridayPressed(_ sender: Any) {
        if fridayButton.isSelected == false {
            fridayButton.isSelected = true
            weekdays[5] = "friday"
            print(weekdays)
        }else{
            fridayButton.isSelected = false
            weekdays[5] = "f"
            print(weekdays)
        }
    }
    
    @IBAction func saturdayPressed(_ sender: Any) {
        if saturdayButton.isSelected == false {
            saturdayButton.isSelected = true
            weekdays[6] = "saturday"
            print(weekdays)
        }else{
            saturdayButton.isSelected = false
            weekdays[6] = "s"
            print(weekdays)
        }
    }
    
    
    
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
        
        if alarm == true {
        let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: (titleField.text)!, arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: (detailsField.text), arguments: nil)
                content.sound = UNNotificationSound(named: "LovelyBell.mp3")
        
            let triggerDaily = Calendar.current.dateComponents([.hour,.minute,.second,], from: timePicker.date)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
            
            //let triggerWeekly = Calendar.current.dateComponents([.weekday,hour,.minute,.second,], from: date)
            //let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
            
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
            let request = UNNotificationRequest(identifier: "\(String(describing: titleField.text)))PopUpReminder", content: content, trigger: trigger)
                let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
            
            
            
        }else{
            func removePendingNotificationRequests(withIdentifiers identifiers: [String]){
                

            
            }
            
        }
        
        //removeAllPendingNotificationRequests()
        
        var item: Item
        let picture = Image(context: context)
        picture.image = thumgImg.image
        
        item = itemToEdit ?? Item(context: context)
        
        
         item.toImage = picture
        
        //print(alarm)
        //print(item.bell)
        
        if let title = titleField.text {
            
            item.title = title
            
            
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
        
        
        item.eventTime = timePicker.date
            
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        item.bell = alarm
        ad.saveContext()
        
        
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
            timeDisplay.text = item.time
            titleField.text = item.title
            locationField.text = item.location
            alarm = item.bell
            
            if (alarm == true) {
                toggleReminderButton.setImage(UIImage(named:"bell-button-1.png"), for: [])
            }
            else {
                toggleReminderButton.setImage(UIImage(named:"bell-button-2.png"), for: [])
            }
            detailsField.text = item.details
            itemTypeField.text = item.itemType
            
            if itemTypeField.text == "Practice" {
                 practiceButton.isSelected = true
                 scheduleButton.isSelected = false
                 timePicker.isHidden = true
            } else if itemTypeField.text == "Schedule" {
                scheduleButton.isSelected = true
                practiceButton.isSelected = false
                timePicker.isHidden = false
            }
            thumgImg.image = item.toImage?.image as? UIImage
            timePicker.date = item.eventTime!
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
    
    var toggleState = 1
    let imgOff = UIImage(named:"bell-button-1.png")
    let imgOn = UIImage(named:"bell-button-2.png")
    
    
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        
        if alarm == false {
            
            toggleReminderButton.setImage(imgOff, for: [])
            alarm = true
            if alarm == true {
                print("True")
            }
            
        } else {
            
            alarm = true
            toggleReminderButton.setImage(imgOn,for: [])
            alarm = false
            if alarm == false {
                print("false")
            }
        }
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            thumgImg.image = img
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
    
}

//extension ItemDetailsVC : CHDayPickerDelegate {
//    func didSelectDay(position: Int, label: String, selected : Bool) {
//        self.resultLabel.text = "\(position) : \(label)"
//    }
//}

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



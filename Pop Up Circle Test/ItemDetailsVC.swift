//
//  ItemDetailsVC.swift
//  PopUpZendo
//
//  Created by Joseph Hall on 6/19/17.
//  Copyright © 2017 Joseph Hall All rights reserved.


import UIKit
import CoreData
import DLRadioButton
import UserNotifications


class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
  

  
    @IBOutlet weak var bellSwitch: UISwitch!
    
    @IBOutlet weak var eventTimeValue: UILabel!
    @IBOutlet weak var bellValue: UILabel!
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet var timePicker:UIDatePicker!
    @IBOutlet weak var dateTimeDisplay: CustomTextField!

    @IBOutlet weak var timeDisplay: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var itemTypeField: CustomTextField!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var locationField: CustomTextField!
    @IBOutlet weak var scheduleButton: DLRadioButton!
    @IBOutlet weak var practiceButton: DLRadioButton!
    @IBOutlet weak var toggleReminderButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    
    
    
    var weekdays_list = [NSManagedObject]()
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    var eventTimeCalc: Date?
    
    var weekdays: [String] = ["s", "m", "t", "w", "t", "f", "s"]
    
    var sundayBool: Bool = false
    var mondayBool: Bool = false
    var tuesdayBool: Bool = false
    var wednesdayBool: Bool = false
    var thursdayBool: Bool = false
    var fridayBool: Bool = false
    var saturdayBool: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self
        
        self.hideKeyboardOnTap(#selector(self.dismissKeyboard))
        
        func saveButtonText () {
            if practiceButton.isSelected == false && scheduleButton.isSelected == false {
                saveButton.isHidden = true

            }else{

                saveButton.isHidden = true
            }
        }

        saveButtonText()
    
        itemTypeField.delegate = self
        timeView.isHidden = true
        thumgImg.isHidden = true
        hideButton.isHidden = true
        
        titleField.delegate = self
        detailsField.delegate = self
        itemTypeField.delegate = self
        
        titleField.returnKeyType = .done
        detailsField.returnKeyType = .done
        itemTypeField.returnKeyType = .done
        
        
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText     text: String) -> Bool {
        if text == "\n"
        {
            detailsField.resignFirstResponder()
            return false
        }
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
        if sundayBool == false {
            sundayButton.setImage(UIImage(named:"sOn"), for: [])
            weekdays[0] = "Sunday"
            sundayBool = true
            print(weekdays)
        }else{
            sundayButton.setImage(UIImage(named:"sOff"), for: [])
            weekdays[0] = "s"
            sundayBool = false
            print(weekdays)
        }
        
    }
    
    @IBAction func mondayPressed(_ sender: Any) {
        if mondayBool == false {
            mondayButton.setImage(UIImage(named:"mOn"), for: [])
            weekdays[1] = "Monday"
            mondayBool = true
            
            print(weekdays)
        }else{
            mondayButton.setImage(UIImage(named:"mOff"), for: [])
            weekdays[1] = "m"
            mondayBool = false
            print(weekdays)
            
        }
    }
    
    @IBAction func tuesdayPressed(_ sender: Any) {
        if tuesdayBool == false {
            tuesdayButton.setImage(UIImage(named:"tOn"), for: [])
            weekdays[2] = "Tuesday"
            tuesdayBool = true
            print(weekdays)
        }else{
            tuesdayButton.setImage(UIImage(named:"tOff"), for: [])
            weekdays[2] = "t"
            tuesdayBool = false
            print(weekdays)
        }
    }
    
    @IBAction func wednesdayPressed(_ sender: Any) {
        if wednesdayBool == false {
            wednesdayButton.setImage(UIImage(named:"wOn"), for: [])
            weekdays[3] = "Wednesday"
            wednesdayBool = true
            print(weekdays)
        }else{
            wednesdayButton.setImage(UIImage(named:"wOff"), for: [])
            weekdays[3] = "w"
            wednesdayBool = false
            print(weekdays)
        }
    }
    
    @IBAction func thursdayPressed(_ sender: Any) {
        if thursdayBool == false {
            thursdayButton.setImage(UIImage(named:"tOn"), for: [])
            weekdays[4] = "Thursday"
            thursdayBool = true
            print(weekdays)
        }else{
            thursdayButton.setImage(UIImage(named:"tOff"), for: [])
            weekdays[4] = "t"
            thursdayBool = false
            print(weekdays)
        }
    }
    
    @IBAction func fridayPressed(_ sender: Any) {
        if fridayBool == false {
            fridayButton.setImage(UIImage(named:"fOn"), for: [])
            weekdays[5] = "Friday"
            fridayBool = true
            print(weekdays)
        }else{
            fridayButton.setImage(UIImage(named:"fOff"), for: [])
            weekdays[5] = "f"
            fridayBool = false
            print(weekdays)
        }
    }
    
    @IBAction func saturdayPressed(_ sender: Any) {
        if saturdayBool == false {
            saturdayButton.setImage(UIImage(named:"sOn"), for: [])
            weekdays[6] = "Saturday"
            saturdayBool = true
            print(weekdays)
        }else{
        saturdayButton.setImage(UIImage(named:"sOff"), for: [])
            weekdays[6] = "s"
            saturdayBool = false
            print(weekdays)
        }
    }
    
    @IBAction func keyBye(_ sender: UITapGestureRecognizer) {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    
//    @IBAction func timeShow(_ sender: Any) {
//        if timePicker.isHidden == true {
//            timePicker.isHidden = false
//        } else { timePicker.isHidden = true
//
//        }
//    }
    
    @IBAction func radioPractice(_ sender: Any) {
        hideButton.isHidden = false;
        thumgImg.isHidden = false;
        itemTypeField.text = "Practice"
        timeView.isHidden = true
        saveButton.isHidden = false
        
    }
    
    @IBAction func radioSchedule(_ sender: Any) {
         print(timePicker.isHidden)
        
        if timePicker.isHidden == true {
            
            timePicker.isHidden = false
            hideButton.isHidden = true
            timeView.isHidden = false
            itemTypeField.text = "Schedule"
            saveButton.isHidden = false
            
        } else {
            timePicker.isHidden = true
            timeView.isHidden = true
        }
        }
    
    
    //Saving the data
    
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
        
        
            
       //item.days = ["Sunday", "Monday", "Tuesday"]
        
        
        
        item.eventTime = timePicker.date
            
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        item.bell = alarm
        
        item.sunday = sundayBool
        item.monday = mondayBool
        item.tuesday = tuesdayBool
        item.wednesday = wednesdayBool
        item.thursday = thursdayBool
        item.friday = fridayBool
        item.saturday = saturdayBool
        
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
                 timeView.isHidden = true
            } else if itemTypeField.text == "Schedule" {
                scheduleButton.isSelected = true
                practiceButton.isSelected = false
                timeView.isHidden = false
            }
            thumgImg.image = item.toImage?.image as? UIImage
            timePicker.date = item.eventTime!
            
            sundayBool = item.sunday
            mondayBool = item.monday
            tuesdayBool = item.tuesday
            wednesdayBool = item.wednesday
            thursdayBool = item.thursday
            fridayBool = item.friday
            saturdayBool = item.saturday
            
            if (sundayBool == true) {
                sundayButton.setImage(UIImage(named:"sOn"), for: [])
            }
            else {
                sundayButton.setImage(UIImage(named:"sOff"), for: [])
            }
            
            mondayBool = item.monday
            
            if (mondayBool == true) {
                mondayButton.setImage(UIImage(named:"mOn"), for: [])
            }
            else {
                mondayButton.setImage(UIImage(named:"mOff"), for: [])
            }
            
            tuesdayBool = item.tuesday
            
            if (tuesdayBool == true) {
                tuesdayButton.setImage(UIImage(named:"tOn"), for: [])
            }
            else {
                tuesdayButton.setImage(UIImage(named:"tOff"), for: [])
            }
            
            wednesdayBool = item.wednesday
            
            if (wednesdayBool == true) {
                wednesdayButton.setImage(UIImage(named:"wOn"), for: [])
            }
            else {
                wednesdayButton.setImage(UIImage(named:"wOff"), for: [])
            }
            
            thursdayBool = item.thursday
            
            if (thursdayBool == true) {
                thursdayButton.setImage(UIImage(named:"tOn"), for: [])
            }
            else {
                thursdayButton.setImage(UIImage(named:"tOff"), for: [])
            }
            
            fridayBool = item.friday
            
            if (fridayBool == true) {
                fridayButton.setImage(UIImage(named:"fOn"), for: [])
            }
            else {
                fridayButton.setImage(UIImage(named:"fOff"), for: [])
            }
            
            saturdayBool = item.saturday
            
            if (saturdayBool == true) {
                saturdayButton.setImage(UIImage(named:"sOn"), for: [])
            }
            else {
                saturdayButton.setImage(UIImage(named:"sOff"), for: [])
            }
            
            
            
        }
        timeView.isHidden = true
        
        
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
                print("True Alarm")
            }
            
        } else {
            
            alarm = true
            toggleReminderButton.setImage(imgOn,for: [])
            alarm = false
            if alarm == false {
                print("false alarm")
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



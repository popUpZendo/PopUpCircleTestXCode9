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


class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  

  
    @IBOutlet weak var bellSwitch: UISwitch!
    
    
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
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    
    var stores = [Store]()
    var itemToEdit: Item?
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bellValue.text = "Yes"
        
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
    
    @IBAction func switchChanged(_ sender: Any) {
        if bellSwitch.isOn {
            bellValue.text = "Yes"
        }
        else {
            bellValue.text = "No"
        }
    }
    
    @IBAction func timePickerChanged(_ sender: AnyObject) {
        setTime()
    }
    
    
    func setTime() {
        timeFormatter.timeStyle = DateFormatter.Style.short
        dateTimeDisplay.text = timeFormatter.string(from: timePicker.date)
        
        timeDisplay.text = timeFormatter.string(from: timePicker.date)
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
    
    /*@IBAction func bellSwitchIsChanged(_ sender: Any) {
        if bellSwitch.isOn {
            item.time = true
        } else {
            item.bell = false
        }
    }*/
    
    
    
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
        
        if let details = detailsField.text {
            
            item.details = details
            
        }
        
        /*if let bell = bellSwitch.bool {
            item.bell = bell
        }*/
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
            timeDisplay.text = item.time
            titleField.text = item.title
            locationField.text = item.location
            //bell.bool = item.bell
            detailsField.text = item.details
            itemTypeField.text = item.itemType
            thumgImg.image = item.toImage?.image as? UIImage
            
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


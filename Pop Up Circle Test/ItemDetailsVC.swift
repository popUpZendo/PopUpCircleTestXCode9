//
//  ItemDetailsVC.swift
//  DreamLister
//
//  Created by Jonny B on 8/19/16.
//  Copyright © 2016 Jonny B. All rights reserved.


import UIKit
import CoreData
import DLRadioButton


class ItemDetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  

    @IBOutlet var timePicker:UIDatePicker!
    @IBOutlet weak var dateTimeDisplay: UILabel!
    @IBOutlet weak var timeDisplay: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField: CustomTextField!
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
        
        itemTypeField.delegate = self
    self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
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
        itemTypeField.text = "Practice"
    }
    
    @IBAction func radioSchedule(_ sender: Any) {
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
        
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func loadItemData() {
        
        if let item = itemToEdit {
            timeDisplay.text = item.time
            titleField.text = item.title
            locationField.text = item.location
            
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

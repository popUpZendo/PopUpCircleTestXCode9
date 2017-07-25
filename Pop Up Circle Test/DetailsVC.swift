//
//  DetailsVC.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 7/23/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit
import CoreData
import DLRadioButton


class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet weak var hideButton: UIButton!
    @IBOutlet weak var dateTimeDisplay: UILabel!
    @IBOutlet weak var timeDisplay: CustomTextField!
    @IBOutlet weak var titleField: CustomTextField!
    @IBOutlet weak var detailsField: UITextView!
    @IBOutlet weak var itemTypeField: CustomTextField!
    @IBOutlet weak var thumgImg: UIImageView!
    @IBOutlet weak var locationField: CustomTextField!
    
    
    
    
    
    
    
    var weekdays_list = [NSManagedObject]()
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    
    
    var itemToEdit: Item?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        itemTypeField.delegate = self
        thumgImg.isHidden = true
        hideButton.isHidden = true
        
        
        
        
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        
        if itemToEdit != nil {
            loadItemData()
        }
        
        
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
    
    
        
}
    
    

    
    

        
        
        


    
    








//
//  Test Area.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/10/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit
import Firebase
import OneSignal

class Test_Area: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var playerIDLabel: UILabel!
    @IBOutlet weak var getIDButton: UIButton!
    @IBOutlet weak var playerIDTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        DataService.instance.getPlayerID(forUID: (Auth.auth().currentUser?.uid)!, handler: (user.childSnapshot(forPath: "playerID").value as? String ?? "defaultValue"))
       // print (playerID)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getNumberPressed(_ sender: Any) {
        if let text = playerIDTextField.text, !text.isEmpty {
            databaseRef.child("onesignal").child("ZtcfskmMydQmGIarYyKiuO6cKbh1").child("playerID").observeSingleEvent(of: .childAdded) {
                (snapshot) in
                let phoneDB = snapshot.value as? String
                self.playerIDLabel.text = phoneDB
                print (text)
            }
        }
        
        
        }
    
        @IBAction func sendMessage(_ sender: Any) {
            OneSignal.postNotification(["contents": ["en": "Test Message"], "include_player_ids": ["bebe0a9e-b5f9-4e8c-9c2f-2f23e5f6054e"]])
        }

    
    }
    

    



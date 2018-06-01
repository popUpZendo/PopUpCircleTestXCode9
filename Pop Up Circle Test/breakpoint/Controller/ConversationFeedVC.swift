//
//  ConversationFeedVC.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit
import Firebase
import OneSignal

class ConversationFeedVC: UIViewController {
    
    var sender: String = "test"
    var myName = "yielding"

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var conversationTitleLbl: UILabel!
    @IBOutlet weak var sendButtonView: UIView!
    @IBOutlet weak var messageTextField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet var mainView: UIView!
    
    
    var conversation: Conversation?
    var conversationMessages = [Message]()
    
    func initData(forConversation conversation: Conversation) {
        self.conversation = conversation
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.bindToKeyboard()
        tableView.delegate = self
        tableView.dataSource = self
        
        //self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //self.view.addGestureRecognizer(self.revealViewController()  .tapGestureRecognizer())
        self.mainView.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        func getMyName(completion: @escaping (String) -> ()){
            if let uid = Auth.auth().currentUser?.uid{
                databaseRef.child("bodhi").child((uid)).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let bodhiDict = snapshot.value as? [String: AnyObject]
                    {
                        let myName = (bodhiDict["Name"] as? String)!
                        print ("myName in the closure: \(myName)")
                        completion(myName)
                    } else {
                        completion("")
                    }
                })
            }
        }
        
        getMyName(completion: { (name) in
            print("Received \(name)")
            self.myName = name
            
        })
    }
    
    deinit {
        //sendButtonView.unBindFromKeyboard()
        mainView.unbindFromKeyboard()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.messageTextField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        conversationTitleLbl.text = conversation?.conversationTitle
        DataService.instance.getEmailsForConversation(conversation: conversation!) { (returnedEmails) in
            //self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        
        DataService.instance.REF_CONVERSATION.observe(.value) {(snapshot) in
            DataService.instance.getConversation(desiredConversation: self.conversation!, handler: { (returnedConversationMessages) in
                self.conversationMessages = returnedConversationMessages
                self.tableView.reloadData()
                
                if self.conversationMessages.count > 0 {
                    self.tableView.scrollToRow(at: IndexPath(row: self.conversationMessages.count - 1, section: 0), at: .none, animated: true)
                }
            })
            
        }
        
    }
    
    
    
    @IBAction func SendBtnWasPressed(_ sender: Any) {
        if messageTextField.text != "" {
            messageTextField.isEnabled = false
            sendBtn.isEnabled = false
            
            // See the Create notification REST API POST call for a list of all possible options: https://documentation.onesignal.com/reference#create-notification
            // NOTE: You can only use include_player_ids as a targeting parameter from your app. Other target options such as tags and included_segments require your OneSignal App REST API key which can only be used from your server.
            let status: OSPermissionSubscriptionState = OneSignal.getPermissionSubscriptionState()
            let pushToken = status.subscriptionStatus.pushToken
            let userId = status.subscriptionStatus.userId
            var friendId = "bebe0a9e-b5f9-4e8c-9c2f-2f23e5f6054e"
            
            if pushToken != nil {
                let message = messageTextField.text
                let notificationContent = [
                    "include_player_ids": [friendId],
                    "contents": ["en": message], // Required unless "content_available": true or "template_id" is set
                    "headings": ["en": myName],
                    //"subtitle": ["en": "An English Subtitle"],
                    // If want to open a url with in-app browser
                    //"url": "https://google.com",
                    // If you want to deep link and pass a URL to your webview, use "data" parameter and use the key in the AppDelegate's notificationOpenedBlock
                    //"data": ["OpenURL": "https://imgur.com"],
                    //"ios_attachments": ["id" : "https://cdn.pixabay.com/photo/2017/01/16/15/17/hot-air-balloons-1984308_1280.jpg"],
                    "ios_badgeType": "Increase",
                    "ios_badgeCount": 1
                    ] as [String : Any]
                
                OneSignal.postNotification(notificationContent)
            }
        
            
            DataService.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser!.uid, withGroupKey: nil, withConversationKey: conversation?.key, sendComplete: { (complete) in
                if complete {
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                }
            })
            
        }
        
    }
    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
}

extension ConversationFeedVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "conversationFeedCell", for: indexPath) as? ConversationFeedCell else  { return UITableViewCell() }
        let message = conversationMessages[indexPath.row]
        
        
        
        DataService.instance.getUsername(forUID: message.senderId) { (email) in
            cell.configureCell(profile_image: UIImage(named: "defaultProfileImage")!, email: email!, content: message.content, senderId: message.senderId)
        }
        return cell
    }
}

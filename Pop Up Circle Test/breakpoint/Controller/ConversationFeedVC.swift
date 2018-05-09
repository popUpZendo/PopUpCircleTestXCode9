//
//  ConversationFeedVC.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit
import Firebase

class ConversationFeedVC: UIViewController {

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
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
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

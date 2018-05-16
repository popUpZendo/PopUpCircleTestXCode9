//
//  ConversationsVC.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit

class ConversationsVC: UIViewController {

    @IBOutlet weak var conversationsTableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    var conversationsArray = [Conversation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()  .tapGestureRecognizer())
        
        conversationsTableView.delegate = self
        conversationsTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DataService.instance.REF_CONVERSATION.observe(.value) { (snapshot) in
            DataService.instance.getAllConversations { (returnedConversationsArray) in
                self.conversationsArray = returnedConversationsArray
                //print ("this is the \(self.returnedConversationsArray)")
                //let conversationTitle = returnedConversationsArray.members.value
                self.conversationsTableView.reloadData()
            }
        }
    }
}

extension ConversationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = conversationsTableView.dequeueReusableCell(withIdentifier: "conversationCell", for: indexPath) as? ConversationCell else {return UITableViewCell()}
        let conversation = conversationsArray[indexPath.row]
        cell.configureCell(title: conversation.conversationTitle, description: "nil", memberCount: conversation.conversationMemberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let conversationFeedVC = storyboard?.instantiateViewController(withIdentifier: "ConversationFeedVC") as? ConversationFeedVC else { return }
        conversationFeedVC.initData(forConversation: conversationsArray[indexPath.row])
        presentDetail(conversationFeedVC)
    }
    
    
}




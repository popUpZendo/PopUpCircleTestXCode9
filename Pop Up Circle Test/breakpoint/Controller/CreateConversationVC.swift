//
//  CreateConversationVC.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/5/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit
import Firebase

class CreateConversationVC: UIViewController {
    
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    
    @IBOutlet weak var conversationMemberLbl: UILabel!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var emailArray = [String]()
    var chosenUserArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTextField.delegate = self
        emailSearchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDidChange() {
        if emailSearchTextField.text == "" {
            emailArray = []
            tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: emailSearchTextField.text!, handler: { (returnedEmailArray) in
                self.emailArray = returnedEmailArray
                self.tableView.reloadData()
            })
        }
    }
    
    @IBAction func doneBtnWasPressed(_ sender: Any) {
        if titleTextField.text != "" {
            DataService.instance.getIds(forUsernames: chosenUserArray, handler: { (idsArray) in
                var userIds = idsArray
                userIds.append((Auth.auth().currentUser?.uid)!)
                
                print (self.chosenUserArray)
                
                DataService.instance.createConversation(withTitle: self.titleTextField.text!, forUserIds: userIds, handler: { (conversationCreated) in
                    if conversationCreated {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        print("Conversation could not be created. Please try again.")
                    }
                })
            })
        }
    }
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateConversationVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? UserCell else { return UITableViewCell() }
        let profileImage = UIImage(named: "defaultProfileImage")
        
        if chosenUserArray.contains(emailArray[indexPath.row]) {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: true)
        } else {
            cell.configureCell(profileImage: profileImage!, email: emailArray[indexPath.row], isSelected: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else {return}
        if !chosenUserArray.contains(cell.emailLbl.text!) {
            chosenUserArray.append(cell.emailLbl.text!)
            conversationMemberLbl.text = chosenUserArray.joined(separator: ", ")
            doneBtn.isHidden = false
        } else {
            chosenUserArray = chosenUserArray.filter({ $0 != cell.emailLbl.text!})
            if chosenUserArray.count >= 1 {
                conversationMemberLbl.text = chosenUserArray.joined(separator: ", ")
            } else {
                conversationMemberLbl.text = "add people to your conversation"
                doneBtn.isHidden = true
            }
        }
    }
}

extension CreateConversationVC: UITextFieldDelegate {
    
}

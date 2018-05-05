//
//  ConversationFeedCell.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 5/2/18.
//  Copyright © 2018 Om Design. All rights reserved.
//

import UIKit
import Firebase

class ConversationFeedCell: UITableViewCell {

    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    var sender: String = "test"
    
    
    func configureCell(profile_image: UIImage, email: String, content: String, senderId: String) {
        sender = (senderId as? String)!
        "\"\(senderId)\""
        setupProfile()
        self.profile_image.image = profile_image
        self.emailLbl.text = email
        self.contentLbl.text = content
    }
    
    
    func setupProfile(){
        
        profile_image.layer.cornerRadius = profile_image.frame.size.width/2
        profile_image.clipsToBounds = true
        
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("bodhi").child(sender).observeSingleEvent(of: .value, with: { (snapshot) in
                if let bodhiDict = snapshot.value as? [String: AnyObject]
                {
                    self.emailLbl.text = bodhiDict["Name"] as? String
                }
            })
        }
        
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(sender).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    
                    if let profileImageURL = dict["pic"] as? String
                        
                    {
                        let url = URL(string: profileImageURL)
                        if url != nil {
                            URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                                if error != nil{
                                    print(error!)
                                    return
                                }
                                DispatchQueue.main.async {
                                    self.profile_image?.image = UIImage(data: data!)
                                }
                            }).resume()
                            
                        }else{
                            self.profile_image?.image = #imageLiteral(resourceName: "profileZen")
                        }
                        
                    }
                }
            })
        }
    }
    
}


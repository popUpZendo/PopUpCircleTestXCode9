//
//  SanghaCell.swift
//  bodhi
//
//  Created by Joseph Hall on 10/31/17.
//  Copyright © 2017 Joseph Hall. All rights reserved.
//

import UIKit
import Firebase

class SanghaCell: UITableViewCell {
    
    @IBOutlet weak var profile_image: UIImageView!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var groupLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var stateLbl: UILabel!
    @IBOutlet weak var templeLbl: UILabel!
    @IBOutlet weak var teacherLbl: UILabel!
    @IBOutlet weak var practiceLbl: UILabel!
    
    var sender: String = "test"
    
    func configureSanghaCell(profile_image: UIImage, name: String, popUpGroup: String, city: String, state: String, temple: String, teacher: String, practice: String, senderId: String) {
        sender = (senderId as? String)!
        "\"\(senderId)\""
        setupProfile()
        self.profile_image.image = profile_image
        self.nameLbl.text = name
        self.groupLbl.text = popUpGroup
        self.cityLbl.text = city
        self.stateLbl.text = state
        self.templeLbl.text = temple
        self.teacherLbl.text = teacher
        self.practiceLbl.text = practice
    }
    
    func setupProfile(){
        
        profile_image.layer.cornerRadius = profile_image.frame.size.width/2
        profile_image.clipsToBounds = true
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

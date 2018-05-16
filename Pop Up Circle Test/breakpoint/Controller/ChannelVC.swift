//
//  ChannelVC.swift
//  Smack
//
//  Created by Joseph Hall on 9/30/17.
//  Copyright © 2017 Joseph Hall. All rights reserved.
//

import UIKit
import Firebase

class ChannelVC: UIViewController {
    @IBOutlet weak var profile_image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.width - 60
        setupProfile()
        
    }

    
    @IBAction func logoutButton(_ sender: Any) {
        logout()
    }
    
    
    func setupProfile(){
        profile_image.layer.cornerRadius = profile_image.frame.size.width/2
        profile_image.clipsToBounds = true
        if let uid = Auth.auth().currentUser?.uid{
            databaseRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? [String: AnyObject]
                {
                    //self.usernameLabel.text = dict["username"] as? String
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
    
    func logout(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "AuthVC")
        present(loginViewController, animated: true, completion: nil)
    }
    
}

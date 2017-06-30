//
//  ViewController.swift
//  PartyRockApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit

class LearningVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var partyRocks = [PartyRock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let p1 = PartyRock(imageURL: "https://i.ytimg.com/vi/9mH07qCLci0/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9mH07qCLci0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Entering the Zendo")
        let p2 = PartyRock(imageURL: "https://i.ytimg.com/vi/9ZGeCkWNFMQ/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=HP-KpGhvbBZjbtcYBy_2eTD3z1g", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9ZGeCkWNFMQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Sitting Posture")
        let p3 = PartyRock(imageURL: "https://i.ytimg.com/vi/ZKOYUigvoTs/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=QTRZQ58DG8uQTNjItmAU9SrlcCw", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ZKOYUigvoTs\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Meditation Instructions")
        let p4 = PartyRock(imageURL: "https://i.ytimg.com/vi/9db6WrcdfVY/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=guFzHYejU5KV5EuUlr8BDjj2NSg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9db6WrcdfVY\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Oryoki")
        let p5 = PartyRock(imageURL: "https://i.ytimg.com/vi/3Xqtm-pqMwA/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=K87TvvF-VaW-IxSDahGIubI4A0wg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/3Xqtm-pqMwA\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "About Kobun and Suzuki")
        
        partyRocks.append(p1)
        partyRocks.append(p2)
        partyRocks.append(p3)
        partyRocks.append(p4)
        partyRocks.append(p5)
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
     
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell {
            
            let partyRock = partyRocks[indexPath.row]
            
            cell.updateUI(partyRock: partyRock)
            
            return cell
            
        } else {
        return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRocks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let partyRock = partyRocks[indexPath.row]
        
        performSegue(withIdentifier: "VideoVC", sender: partyRock)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? VideoVC {
            
            if let party = sender as? PartyRock {
                destination.partyRock = party
            }
        }
    
    }


}

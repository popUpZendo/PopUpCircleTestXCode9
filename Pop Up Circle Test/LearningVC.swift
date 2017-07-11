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
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        let p1 = PartyRock(imageURL: "https://i.ytimg.com/vi/fGCo_wx97mo/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/fGCo_wx97mo\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "This is Water", details: "What is Zen in real life terms?", contentURL: "http://www.nytimes.com/2009/04/26/books/review/Bissell-t.html")
        let p2 = PartyRock(imageURL: "https://i.ytimg.com/vi/vbLEf4HR74E/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/vbLEf4HR74E\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "The Habits of Happiness", details: "A simple practice that can change a life", contentURL: "http://www.thewayofmeditation.com.au/blog/worlds-happiest-man/")
        
        let p3 = PartyRock(imageURL: "https://i.ytimg.com/vi/Bg21M2zwG9Q/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLA6lsGlNknfDWGHdwRD9RA2enSbUg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/Bg21M2zwG9Q\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Wax On, Wax Off",details: "The value of simple practice", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/231")
        
        let p4 = PartyRock(imageURL: "http://www.rethinkchurch.org/articles/spirituality/stop.-look.-go", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gXDMoiEkyuQ?t=3m46s\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Stop-Look-Go",details: "Cultivating Gratitude", contentURL: "http://www.rethinkchurch.org/articles/spirituality/stop.-look.-go")
        let p5 = PartyRock(imageURL: "http://news.wisc.edu/newsphotos/images/WLBIB_monk_EEG08_2849.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ELLeIMFIWy0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Hardwiring the Brain",details: "The new science of sculpting the mind", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/110")
        let p6 = PartyRock(imageURL: "https://www.youtube.com/yts/img/pixel-vfl3z5WfW.gif", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/XZbVLvT7qBU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Jedi Mind Training",details: "We are going to have to fix the mind with the mind", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/122")
        let p7 = PartyRock(imageURL: "https://i.ytimg.com/vi/UyyjU8fzEYU/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/UyyjU8fzEYU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "My Stroke of Insight", details: "The accidental Buddhist", contentURL: "")
        let p8 = PartyRock(imageURL: "https://i.ytimg.com/vi/unX4FQqM6vI/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=K87TvvF-VaW-IxSDahGIubI4A0wg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/unX4FQqM6vI\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "A Meditation on Altruistic Compassion", details: "Core compassion training", contentURL: "")
        let p9 = PartyRock(imageURL: "https://i.ytimg.com/vi/9ZGeCkWNFMQ/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=HP-KpGhvbBZjbtcYBy_2eTD3z1g", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9ZGeCkWNFMQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Sitting Posture", details: "If you take the posture of a Buddha, you are Buddha", contentURL: "")
        let p10 = PartyRock(imageURL: "https://i.ytimg.com/vi/ZKOYUigvoTs/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=QTRZQ58DG8uQTNjItmAU9SrlcCw", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ZKOYUigvoTs\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Meditation Instructions", details: "How to Do Zazen", contentURL: "")
        let p11 = PartyRock(imageURL: "https://i.ytimg.com/vi/9mH07qCLci0/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9mH07qCLci0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Entering the Zendo", details: "Basic Forms", contentURL: "")
        let p12 = PartyRock(imageURL: "https://i.ytimg.com/vi/3Xqtm-pqMwA/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=K87TvvF-VaW-IxSDahGIubI4A0wg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/3Xqtm-pqMwA\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "About Kobun and Suzuki", details: "How Zen got to America",contentURL: "")
        let p13 = PartyRock(imageURL: "https://i.ytimg.com/vi/9db6WrcdfVY/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=guFzHYejU5KV5EuUlr8BDjj2NSg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9db6WrcdfVY\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Oryoki", details: "Oryoki does itself",contentURL: "")
        
        
        
        
        partyRocks.append(p1)
        partyRocks.append(p2)
        partyRocks.append(p3)
        partyRocks.append(p4)
        partyRocks.append(p5)
        partyRocks.append(p6)
        partyRocks.append(p7)
        partyRocks.append(p8)
        partyRocks.append(p9)
        partyRocks.append(p10)
        partyRocks.append(p11)
        partyRocks.append(p12)
        partyRocks.append(p13)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell {
            
            let partyRock = partyRocks[indexPath.row]
            
            cell.updateUI(partyRock)
            
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


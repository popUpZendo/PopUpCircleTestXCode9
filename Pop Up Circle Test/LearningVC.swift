//
//  ViewController.swift
//  PopUpZendoApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit

class LearningVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var menuBtn: UIButton!
    
    
    var dharmaRocks = [DharmaRock]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()  .tapGestureRecognizer())
        
        let p1 = DharmaRock(imageURL: "https://i.ytimg.com/vi/fGCo_wx97mo/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/fGCo_wx97mo\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "This is Water", details: "What is Zen in real life terms?", contentURL: "http://americablog.com/2015/05/this-is-water-what-david-foster-wallace-wanted-us-to-think-about.html")
        let p2 = DharmaRock(imageURL: "https://i.ytimg.com/vi/vbLEf4HR74E/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/vbLEf4HR74E\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "The Habits of Happiness", details: "A simple practice that can change a life", contentURL: "http://www.thewayofmeditation.com.au/blog/worlds-happiest-man/")
        
        let p3 = DharmaRock(imageURL: "https://i.ytimg.com/vi/Bg21M2zwG9Q/hqdefault.jpg?sqp=-oaymwEXCNACELwBSFryq4qpAwkIARUAAIhCGAE=&rs=AOn4CLA6lsGlNknfDWGHdwRD9RA2enSbUg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/Bg21M2zwG9Q\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Wax On, Wax Off",details: "The value of simple practice", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/231")
        
        let p4 = DharmaRock(imageURL: "http://media.masslive.com/breakingnews/photo/2012/10/11707579-large.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/gXDMoiEkyuQ?t=3m46s\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Stop-Look-Go",details: "Cultivating Gratitude", contentURL: "http://www.beliefnet.com/wellness/2001/06/awake-aware-and-alert.aspx")
        let p5 = DharmaRock(imageURL: "http://news.wisc.edu/newsphotos/images/WLBIB_monk_EEG08_2849.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ELLeIMFIWy0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Hardwiring the Brain",details: "The new science of sculpting the mind", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/110")
        let p6 = DharmaRock(imageURL: "http://www.samaracanada.com/images/default-source/blogs/default-album/yoda-and-luke-skywalker.jpg?sfvrsn=1", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/XZbVLvT7qBU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Jedi Mind Training",details: "We are going to have to fix the mind with the mind", contentURL: "http://popupzendo.org/jikoji-zen-center/blog/122")
        let p7 = DharmaRock(imageURL: "https://pi.tedcdn.com/r/pe.tedcdn.com/images/ted/eefe30d20338d800bdc70a09dc0f6007e7355a74_2880x1620.jpg?w=1200", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/UyyjU8fzEYU\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "My Stroke of Insight",details: "An Accidental Buddhist", contentURL: "https://www.psychologytoday.com/blog/use-your-mind-change-your-brain/201305/is-your-brain-meditation")
        let p8 = DharmaRock(imageURL: "https://i.ytimg.com/vi/unX4FQqM6vI/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=K87TvvF-VaW-IxSDahGIubI4A0wg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/unX4FQqM6vI\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "A Meditation on Altruistic Compassion", details: "Core compassion training", contentURL: "https://zenhabits.net/a-guide-to-cultivating-compassion-in-your-life-with-7-practices/")
        let p9 = DharmaRock(imageURL: "https://i.ytimg.com/vi/9ZGeCkWNFMQ/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=HP-KpGhvbBZjbtcYBy_2eTD3z1g", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9ZGeCkWNFMQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Sitting Posture", details: "If you take the posture of a Buddha, you are Buddha", contentURL: "https://zmm.mro.org/teachings/meditation-instructions/")
        let p10 = DharmaRock(imageURL: "https://i.ytimg.com/vi/ZKOYUigvoTs/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=QTRZQ58DG8uQTNjItmAU9SrlcCw", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/ZKOYUigvoTs\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Meditation Instructions", details: "How to Do Zazen", contentURL: "http://wwzc.org/dharma-text/posture-zazen")
        let p11 = DharmaRock(imageURL: "https://i.ytimg.com/vi/9mH07qCLci0/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=xopfv2vIENsZG4NMuyBZ0MxAE24", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9mH07qCLci0\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Entering the Zendo", details: "Basic Forms", contentURL: "http://www.jikoji.org/zendo-sesshin-guidelines/")
        let p12 = DharmaRock(imageURL: "https://i.ytimg.com/vi/3Xqtm-pqMwA/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=67&sigh=K87TvvF-VaW-IxSDahGIubI4A0wg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/3Xqtm-pqMwA\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "About Kobun and Suzuki", details: "How Zen got to America",contentURL: "http://sweepingzen.com/a-light-in-the-mind-kobun-chino-roshi-as-remembered-by-carolyn-atkinson/")
        let p13 = DharmaRock(imageURL: "https://i.ytimg.com/vi/9db6WrcdfVY/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=guFzHYejU5KV5EuUlr8BDjj2NSg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9db6WrcdfVY\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Oryoki", details: "Oryoki does itself",contentURL: "https://shambhala.org/about-shambhala/the-shambhala-path/oryoki/")
        let p14 = DharmaRock(imageURL: "https://breezenriley.files.wordpress.com/2015/02/buddhist2.jpg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/auS1HtAz6Bs&t=40s\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "LovingKindness Meditation", details: "The first practice given to the Buddha's monks",contentURL: "https://www.yogajournal.com/meditation/cultivate-goodness-practice-lovingkindness")
        let p15 = DharmaRock(imageURL: "https://i.ytimg.com/vi/lyu7v7nWzfo/hqdefault.jpg?custom=true&w=336&h=188&stc=true&jpg444=true&jpgq=90&sp=68&sigh=guFzHYejU5KV5EuUlr8BDjj2NSg", videoURL: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/lyu7v7nWzfo\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "The Case Against Reality", details: "The Case Against Reality",contentURL: "https://www.theatlantic.com/science/archive/2016/04/the-illusion-of-reality/479559/")
        
        
        
        
        dharmaRocks.append(p1)
        dharmaRocks.append(p2)
        dharmaRocks.append(p3)
        dharmaRocks.append(p4)
        dharmaRocks.append(p5)
        dharmaRocks.append(p6)
        dharmaRocks.append(p7)
        dharmaRocks.append(p8)
        dharmaRocks.append(p9)
        dharmaRocks.append(p10)
        dharmaRocks.append(p11)
        dharmaRocks.append(p12)
        dharmaRocks.append(p13)
        dharmaRocks.append(p14)
        dharmaRocks.append(p15)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DharmaCell", for: indexPath) as? DharmaCell {
            
            let dharmaRock = dharmaRocks[indexPath.row]
            
            cell.updateUI(dharmaRock)
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dharmaRocks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let dharmaRock = dharmaRocks[indexPath.row]
        
        performSegue(withIdentifier: "VideoVC", sender: dharmaRock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? VideoVC {
            
            if let dharma = sender as? DharmaRock {
                destination.dharmaRock = dharma
            }
        }
        
    }
    

    
}


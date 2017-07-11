//
//  VideoVC.swift
//  PartyRockApp
//
//  Created by Joseph Hall on 5/16/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit

class VideoVC: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var webView2: UIWebView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var details: UILabel!
    
    
    fileprivate var _partyRock: PartyRock!
    
    var partyRock: PartyRock {
        get{
            return _partyRock
        } set {
            _partyRock = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
        titleLbl.text = partyRock.videoTitle
        details.text = partyRock.details
        webView.loadHTMLString(partyRock.videoURL, baseURL: nil)
        
        
    // webView2.loadHTMLString(partyRock.videoURL, baseURL: nil)
        webView2.loadRequest(URLRequest(url: URL(string: partyRock.contentURL)! as URL) as URLRequest)
        
        //webView2.loadHTMLString("https://www.google.com", baseURL: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


//
//  TimerViewController.swift
//  Pop Up Circle Test
//
//  Created by Joseph Hall on 6/21/17.
//  Copyright © 2017 Om Design. All rights reserved.
//

import UIKit
import AVFoundation
import KDCircularProgress
//import CoreData
import Firebase




class TimerViewController: UIViewController {
    
    var progress: KDCircularProgress!
    var btnSound: AVAudioPlayer!
    var zazen: Double = 60
    let defaults = UserDefaults.standard
    let durationSlide = "durationSlide"
    //var timer = 60
    
    
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UISlider!
    @IBOutlet weak var darkMode: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var timerButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let durationSlide = defaults.value(forKey: durationSlide) {
            slider.value = durationSlide as! Float
            durationSliderValueChanged(slider)
        }
        backButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController()  .tapGestureRecognizer())
        
        countDownLabel.isHidden = true
                UIApplication.shared.isIdleTimerDisabled = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = UIColor(white: 1.00, alpha: 1.0)
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        progress.startAngle = -90
        progress.progressThickness = 0.3
        progress.trackThickness = 0.31
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .constant
        progress.glowAmount = 0.3
        progress.trackColor = UIColor.darkGray
        progress.set(colors: UIColor.black)
        progress.center = CGPoint(x: view.center.x, y: view.center.y - 80)
        view.addSubview(progress)
        
        
        let path = Bundle.main.path(forResource: "zazenBell3", ofType: "mp3")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        self.view.bringSubview(toFront: self.timerButton)
        
    }
    
    
   
    @IBAction func lightSwitch(_ sender: UISwipeGestureRecognizer) {
        if self.view.backgroundColor != UIColor.darkGray{

        self.view.backgroundColor = UIColor.darkGray
        } else {
        self.view.backgroundColor = UIColor.white
        }
    }
    
    @IBAction func goBackToOneButtonTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }

    
    @IBAction func sliderChanged(_ sender: UISlider) {
        label.text = String(Int(sender.value))
        zazen = Double(Int(sender.value))
    }
 
    
    
    @IBAction func durationSliderValueChanged(_ sender: UISlider) {
            zazen = Double(Int(sender.value))
            let currentValue = Int(sender.value)
            label.text = "\(currentValue)"
        
        defaults.set(sender.value, forKey: durationSlide)
            print ("currentValue \(currentValue)")
    }
    
    
    
    @IBAction func animateButtonTapped(_ sender: AnyObject){
        if self.progress.isAnimating () || btnSound.isPlaying || countDownLabel.isHidden == false {
            self.progress.stopAnimation()
            self.btnSound.stop()
            label.isHidden = false
            slider.isHidden = false
            sliderValue.isHidden = false
            backButton.isHidden = false
            countDownLabel.isHidden = true
            
        } else {
        
        countDownLabel.isHidden = false
        //var clock = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: "countdown", userInfo: nil, repeats: true)
            label.isHidden = true
            slider.isHidden = true
            sliderValue.isHidden = true
            backButton.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
        
            self.countDownLabel.isHidden = true
            
        func playSound() {
            if self.btnSound.isPlaying {
                self.btnSound.stop()
            } else {
            self.btnSound.play()
            }
        }
        
        playSound()
        
        self.progress.animate(fromAngle: 0, toAngle: 360, duration: self.zazen*60) { completed in
            if completed {
                playSound()
            } else {
                print("animation stopped, was interrupted")
            }
        }
        
        
    })
    }
}
    
    func goBack () {
        var duration = label.text
        let date = Date();
        var isoformatter = ISO8601DateFormatter.init()
        let timeStr = isoformatter.string(from: date)
        // "2016-11-01T21:14:33Z"
        
        // Generete Date from string that being generated
        //var dateFromString = isoformatter.date(from: timeStr)
        // "Nov 2, 2016, 5:14 AM" <-- valid Date
        
        
        DataService.instance.uploadZazen(withDate: timeStr, withDuration: duration!, forUID: (Auth.auth().currentUser?.uid)!, withKey: nil, sendComplete: { (isComplete) in
            if isComplete {
                //self.sendBtn.isEnabled = true
                self.dismiss(animated: true, completion: nil)
            } else {
                //self.sendBtn.isEnabled = true
                print("There was an error!")
            }
        })
    }
    
    func shareZazen() {
        
    }
    
    @IBAction func goBackButton(_ sender: Any) {
            goBack()
    }
    

    
}

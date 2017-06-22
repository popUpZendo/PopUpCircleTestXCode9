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
import CoreData



class TimerViewController: UIViewController {
    
    var progress: KDCircularProgress!
    var btnSound: AVAudioPlayer!
    var zazen: Double = 0
    
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UISlider!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        
        view.backgroundColor = UIColor(white: 1.00, alpha: 0.5)
        
        progress = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 350, height: 350))
        progress.startAngle = -90
        progress.progressThickness = 0.3
        progress.trackThickness = 0.31
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = true
        progress.glowMode = .forward
        progress.glowAmount = 0.3
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
    }
    
    //@IBAction func sliderDidChangeValue(_ sender: UISlider) {
       // progress.angle = Double(sender.value)
    //}
    
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        label.text = String(Int(sender.value))
        zazen = Double(Int(sender.value))
    }
    
    
    @IBAction func animateButtonTapped(_ sender: AnyObject) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            // Put your code which should be executed with a delay here
        
        func playSound() {
            if self.btnSound.isPlaying {
                self.btnSound.stop()
            }
            self.btnSound.play()
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

//
//  CountdownViewController.swift
//  StopWatch
//
//  Created by Adakhanau on 10/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class CountdownerViewController: UIViewController {
    
    
    //MARK: Outlets
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var timeScreen: UILabel!
    
    @IBOutlet weak var sliderOutlet: UISlider!
    @IBOutlet weak var stopOutlet: UIButton!
    
    @IBOutlet weak var pauseOutlet: UIButton!
    @IBOutlet weak var startOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseOutlet.isEnabled = false
        stopOutlet.isEnabled = false
        timeScreen.text = timeString(time: TimeInterval(seconds))
        sliderOutlet.isContinuous = false
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    //Proporties
    var seconds = 30
    var timer = Timer()
    
    
    //MARK: Buttons
    @IBAction func slider(_ sender: UISlider)
    {
        seconds = Int(sender.value)
        timeScreen.text = timeString(time: TimeInterval(seconds))
    }
    
    
    @IBAction func startButton(_ sender: UIButton)
    {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(CountdownerViewController.counter), userInfo: nil, repeats: true)
        
        sliderOutlet.isHidden = true
        startOutlet.isEnabled = false
        stopOutlet.isEnabled = true
        pauseOutlet.isEnabled = true
    }
    
    
    @IBAction func pauseButton(_ sender: UIButton) {
        stop()
        sliderOutlet.setValue(Float(seconds), animated: true)
    }
    
    
    @IBAction func stopButton(_ sender: UIButton)
    {
        stop()
        stopOutlet.isEnabled = false
        seconds = 30
        timeScreen.text = timeString(time: TimeInterval(seconds))
        sliderOutlet.setValue(30, animated: true)
    }
    
    
    //MARK: Functions
    func stop()
    {
        timer.invalidate()
        sliderOutlet.isHidden = false
        pauseOutlet.isEnabled = false
        startOutlet.isEnabled = true
    }
    
    
    @objc func counter()
    {
        if (seconds == 0)
        {
            seconds = 0
            sliderOutlet.setValue(0, animated: true)
            
            stop()
        } else {
            seconds -= 1
        }
        timeScreen.text = timeString(time: TimeInterval(seconds))
    }
    
    func timeString(time:TimeInterval) -> String
    {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
}

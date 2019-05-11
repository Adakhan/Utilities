//
//  ViewController.swift
//  StopWatch
//
//  Created by Adakhanau on 03/04/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {
    
    //Labels
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var timeScreen: UILabel!
    @IBOutlet weak var startLabel: UIButton!
    @IBOutlet weak var pauseLabel: UIButton!
    @IBOutlet weak var resetLabel: UIButton!

    
    //Proporties
    var time = 0
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pauseLabel.isEnabled = false
        resetLabel.isEnabled = false
        timeScreen.text = timeString(time: TimeInterval(time))
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    //Actions
    @IBAction func startButton(_ sender: UIButton) {
    
        runTimer()
        pauseLabel.isEnabled = true
        resetLabel.isEnabled = true
        startLabel.isEnabled = false
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        
        stop()
    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        stop()
        resetLabel.isEnabled = false
        time = 0
        timeScreen.text = timeString(time: TimeInterval(time))
    }
    
    
    //functions
    
    func runTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.action), userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
        startLabel.isEnabled = true
        pauseLabel.isEnabled = false
    }
    
    
    @objc func action() {
        
        time += 1
        timeScreen.text = timeString(time: TimeInterval(time))
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }
    
}


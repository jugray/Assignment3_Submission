//
//  ViewController.swift
//  Assignment3
//
//  Created by Justin Gray on 11/4/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockLabel: UILabel!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var timeRemainingLabel: UILabel!
    
    @IBOutlet weak var startTimerButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var firewatchNight: UIImageView!
    
    @IBOutlet weak var timerTitle: UILabel!
    
    //Full Date
    var dateFormatter = DateFormatter()
    
    //Short date for compare... probably not the best way to do this
    var dateFormatterShort = DateFormatter()
    
    var dateComponentFormatter = DateComponentsFormatter()
    
    var systemTimer = Timer()
    
    var tick :Int = 0
    
    var tock:Int = 0
    
    var timeRemaining:Int = 0
    
    var timerActive : Bool = false
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "EEEE, dd MMM YYY HH:mm:ss"
        dateFormatterShort.dateFormat = "HH"
        dateComponentFormatter.allowedUnits = [.hour, .minute, .second]
        dateComponentFormatter.zeroFormattingBehavior = .pad
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tickTock), userInfo: nil, repeats: true)
        
        //hideTimer on start
        timeRemainingLabel.isHidden =  true;
        timerTitle.isHidden = true
        
        //this should probably run once a second right?
        //setTime()
        blendBackground()
        
    }
    
    @objc func tickTock() {
        setTime()
        tick += 1
        tock += 1
        
        //is timer running?
        if timerActive == true {
            runTimer()
            
            // debug print (timeRemaining)
            if timeRemaining < 0 {
                stopTimer()
            }
        }
        
        //update background every running hour
        if tock == 360 {
            blendBackground()
            tock = 0
        }
        
    }

    func setTime() {
            clockLabel.text = dateFormatter.string(from: Date())
        }
            
    func blendBackground() {
        
        let hourString = dateFormatterShort.string(from: Date())
        let intHrs = Int(hourString)
    
        // Daylight is fireWatchNight.alpha @ 0
        
        
        if firewatchNight.alpha <= 0.7 {
            clockLabel.textColor = .systemCyan
            timerTitle.textColor = .systemCyan
            timeRemainingLabel.textColor = .systemCyan
            startTimerButton.tintColor = .systemCyan
        }
        else{
            clockLabel.textColor = .orange
            timerTitle.textColor = .orange
            timeRemainingLabel.textColor = .orange
            startTimerButton.tintColor = .orange
        }
        
        if intHrs! >= 22 && intHrs! < 4 {
            firewatchNight.alpha = 1
        }
        else if intHrs! >= 4 && intHrs! < 6 {
            firewatchNight.alpha = 0.7
        }
        else if intHrs! >= 6 && intHrs! < 9 {
            firewatchNight.alpha = 0.3
        }
        else if intHrs! >= 9 && intHrs! < 10 {
            firewatchNight.alpha = 0.15
        }
        else if intHrs! >= 10 && intHrs! < 16 {
            firewatchNight.alpha = 0
        }
        else if intHrs! >= 16 && intHrs! < 18 {
            firewatchNight.alpha = 0.4
        }
        else if intHrs! >= 18 && intHrs! < 19 {
            firewatchNight.alpha = 0.6
        }
        else if intHrs! >= 19 && intHrs! < 20 {
            firewatchNight.alpha = 0.8
        }
        else if intHrs! >= 20 && intHrs! < 22 {
            firewatchNight.alpha = 1.0
        }
    
    }

    
    @IBAction func setTimer(_ sender: UIDatePicker) {
                        
        timeRemainingLabel.text = (dateComponentFormatter.string(from: datePicker.countDownDuration))
        
    }
    
    @IBAction func startTimerPushed(_ sender: Any) {
        
        if !timerActive {
            timerActive = true;
            tick = 0
            startTimerButton.setTitle("Stop Timer", for: .normal)
        }
        else  {
            stopTimer()
        }
        
        
    }
    
    func runTimer() {
        // Time Remaining Int
        timeRemaining = Int(datePicker.countDownDuration - Double(tick))
        // Fromatted Time for Label
        timeRemainingLabel.text = dateComponentFormatter.string(from: datePicker.countDownDuration - Double(tick))
        
        if (tick == 1) {
            timeRemainingLabel.isHidden = false
            timerTitle.isHidden = false
        }
        
    }
    
    func stopTimer() {
        timerActive = false
        timeRemainingLabel.isHidden = true
        timerTitle.isHidden  = true
        systemTimer.invalidate()
        startTimerButton.setTitle("Start Timer", for: .normal)

    }
    
}


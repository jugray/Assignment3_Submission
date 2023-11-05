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
    
    //Full Date
    var dateFormatter = DateFormatter()
    
    //Short date for compare... probably not the best way to do this
    var dateFormatterShort = DateFormatter()
    
    var dateComponentFormatter = DateComponentsFormatter()
    
    var tick :Int = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "EEEE, dd MMM YYY HH:mm:ss"
        dateFormatterShort.dateFormat = "HH"
        dateComponentFormatter.allowedUnits = [.hour, .minute, .second]
        dateComponentFormatter.zeroFormattingBehavior = .pad
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tickTock), userInfo: nil, repeats: true)
        
        //this should probably run once a second right?
        //setTime()
        blendBackground()
        
    }
    
    @objc func tickTock() {
        setTime()
        tick += 1
        
        //is timer running?
        
        timeRemainingLabel.text = dateComponentFormatter.string(from: datePicker.countDownDuration - Double(tick))
        

        
        //update background every hour
        if tick == 360 {
            blendBackground()
        }
        
    }

    func setTime() {
            clockLabel.text = dateFormatter.string(from: Date())
        }
            
    func blendBackground() {
        
        let hourString = dateFormatterShort.string(from: Date())
        let intHrs = Int(hourString)
    
        // Daylight is fireWatchNight.alpha @ 0

    
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
            firewatchNight.alpha = 0.2
        }
        else if intHrs! >= 18 && intHrs! < 19 {
            firewatchNight.alpha = 0.4
        }
        else if intHrs! >= 19 && intHrs! < 20 {
            firewatchNight.alpha = 0.6
        }
        else if intHrs! >= 20 && intHrs! < 22 {
            firewatchNight.alpha = 0.8
        }
    
    }

    
    @IBAction func setTimer(_ sender: UIDatePicker) {
                        
        timeRemainingLabel.text = (dateComponentFormatter.string(from: datePicker.countDownDuration))
        
    }
    
    @IBAction func startTimerPushed(_ sender: Any) {
        
    }
    
    func runTimer() {
        
    }
    
}


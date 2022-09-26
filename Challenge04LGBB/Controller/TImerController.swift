//
//  TImerController.swift
//  Mealmories
//
//  Created by Bruno França do Prado on 26/09/22.
//

import Foundation
import UIKit

class TimerController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    var timerCounting:Bool = false
    var startTime:Date?
    var stopTime:Date?
    
    let userDefaults = UserDefaults.standard
    let START_TIME_KEY = "startTime"
    let STOP_TIME_KEY = "stopTime"
    let COUNTING_KEY = "countingKey"
    var scheduledTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        if timerCounting{
            setStopTime(date: Date())
            stopTimer()
        }
        else{
            startTimer()
        }
    }
    
    func startTimer(){
        scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
        startStopButton.setTitle("STOP", for: .normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @objc func refreshValue(){
        if let start = startTime{
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        }
    }
    
    func setTimeLabel(_ val: Int){
        
    }
    
    func stopTimer(){
        if scheduledTimer != nil{
            scheduledTimer.invalidate()
        }
        setTimerCounting(false)
        startStopButton.setTitle("START", for: .normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @IBAction func resetAction(_ sender: Any) {
    }
    
    func setStartTime(date: Date?){
        startTime = date
        userDefaults.set(startTime, forKey: START_TIME_KEY)
    }
    
    func setStopTime(date: Date?){
        stopTime = date
        userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
    }
    
    func setTimerCounting(_ val: Bool){
        timerCounting = val
        userDefaults.set(timerCounting, forKey: COUNTING_KEY)
    }
}

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
    var tempo = 120
    var scheduledTimer: Timer!
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        TimerModel.sharedTimer.removeListener(forKey: "timerController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
        stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
        timerCounting = userDefaults.bool(forKey: COUNTING_KEY)
        setTimeLabel(TimerModel.sharedTimer.currentSeconds)
        
        if TimerModel.sharedTimer.internalTimer != nil{
            TimerModel.sharedTimer.add(listener: { [weak self] seconds in
                DispatchQueue.main.async {
                    self?.setTimeLabel(seconds)
                }
            }, forKey: "timerController")
        }
        else{
            
            setTimeLabel(tempo)
            
//            stopTimer()
//            if let start = startTime{
//                if let stop = stopTime{
//                    let time = calcRestartTime(start: start, stop: stop)
//                    let diff = Date().timeIntervalSince(time)
//                    setTimeLabel(Int(diff))
//                }
//            }
        }
    }
    
    @IBAction func startStopAction(_ sender: Any) {
        if timerCounting{
            setStopTime(date: Date())
            stopTimer()
        }
        else{
            if let stop = stopTime{
                let restartTime = calcRestartTime(start: startTime!, stop: stop)
                setStopTime(date: nil)
                setStartTime(date: restartTime)
            }
            else{
                setStartTime(date: Date())
            }
            startTimer()
        }
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date{
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    func startTimer(){
        TimerModel.sharedTimer.startTimer(withInitialSeconds: tempo,
                                          finalSeconds: 0,
                                          interval: 1,
                                          timerType: .decrease,
                                          withKey: "timerController") { [weak self] seconds in
            DispatchQueue.main.async {
                self?.setTimeLabel(seconds)
            }
        }
//        scheduledTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tempoNovo), userInfo: nil, repeats: true)
        setTimerCounting(true)
        startStopButton.setTitle("STOP", for: .normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @objc func tempoNovo(){
        tempo -= 1
        setTimeLabel(tempo)
        if(tempo == 0){
            stopTimer()
        }
    }
    
    @objc func refreshValue(){
        if let start = startTime{
            let diff = Date().timeIntervalSince(start)
            setTimeLabel(Int(diff))
        }
        else{
            stopTimer()
            setTimeLabel(0)
        }
    }
    
    func setTimeLabel(_ val: Int){
        let time = secondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timeLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int){
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return(hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec:Int) -> String{
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        
        return timeString
    }
    
    func stopTimer(){
//        if scheduledTimer != nil{
//            scheduledTimer.invalidate()
//        }
        TimerModel.sharedTimer.stopTimer()
        setTimerCounting(false)
        startStopButton.setTitle("START", for: .normal)
        startStopButton.setTitleColor(UIColor.red, for: .normal)
    }
    
    @IBAction func resetAction(_ sender: Any) {
        TimerModel.sharedTimer.stopTimer()
        setStopTime(date: nil)
        setStartTime(date: nil)
        timeLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
        stopTimer()
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

class TimerModel {
    enum TimerModelType {
        case increment, decrease
    }
    
    static let sharedTimer: TimerModel = {
        let timer = TimerModel()
        return timer
    }()

    private(set) var internalTimer: Timer?
    private(set) var currentSeconds = 0
    private(set) var finalSeconds = 60
    private var listeners = [String: (Int) -> Void]()
    private var timerModelType: TimerModelType = .increment
    
    private init() {}

    func startTimer(withInitialSeconds initialSeconds: Int,
                    finalSeconds: Int,
                    interval: Double,
                    timerType: TimerModelType,
                    withKey key: String,
                    forListener listener: @escaping (Int) -> Void) {
        if internalTimer == nil {
            internalTimer?.invalidate()
        }
        timerModelType = timerType
        currentSeconds = initialSeconds
        self.finalSeconds = finalSeconds
        listeners[key] = listener
        internalTimer = Timer.scheduledTimer(timeInterval: interval,
                                             target: self,
                                             selector: #selector(notifyListeners),
                                             userInfo: nil,
                                             repeats: true)
    }

    func pauseTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.invalidate()
    }
    
    func resumeTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        internalTimer?.fire()
    }

    func stopTimer() {
        guard internalTimer != nil else {
            print("No timer active, start the timer before you stop it.")
            return
        }
        listeners = [:]
        internalTimer?.invalidate()
        internalTimer = nil
    }
    
    func add(listener: @escaping (Int) -> Void, forKey key: String) {
        listeners[key] = listener
    }
    
    func removeListener(forKey key: String) {
        listeners.removeValue(forKey: key)
    }

    @objc func notifyListeners() {
        currentSeconds += (timerModelType == .decrease) ? -1 : 1
        for listener in listeners.values {
            listener(currentSeconds)
        }
        if currentSeconds == finalSeconds {
            stopTimer()
        }
    }
}


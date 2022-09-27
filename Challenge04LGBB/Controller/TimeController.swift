import Foundation
import UIKit

class TimeController: UIViewController {
    
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var addSeconds: UIButton!
    @IBOutlet weak var minusSeconds: UIButton!
    
    var timer = Timer()
    var seconds = 120
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func setTimeLabel(_ val: Int){
        let time = secondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
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
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int){
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return(hour, min, sec)
    }
    
    @IBAction func startButton(_ sender: Any) {
        timer.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimeController.timerClass), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        
        timer.invalidate()
        
    }
    
    @IBAction func resetButton(_ sender: Any) {
        timer.invalidate()
        seconds = 120
        setTimeLabel(seconds)
    }
    
    @IBAction func addSeconds(_ sender: Any) {
        seconds = seconds + 30
        setTimeLabel(seconds)

    }
    
    @IBAction func minusSeconds(_ sender: Any) {
        seconds = seconds - 30
        setTimeLabel(seconds)

    }
    @objc func timerClass()
    {
        
        seconds -= 1
        setTimeLabel(seconds)
        if(seconds == 0)
        {
            timer.invalidate()
        }
    }
    
}

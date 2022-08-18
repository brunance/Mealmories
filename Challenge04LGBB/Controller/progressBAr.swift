
import Foundation
import UIKit



class ProgressBarController: UIViewController{
    
    @IBOutlet weak var ProgressBar: UIProgressView!
    
    @IBOutlet weak var BotaoProgreso: UIButton!
    override func viewDidLoad() {
        ProgressBar.tintColor = UIColor.red
        ProgressBar.progress = 0.0
        ProgressBar.transform = ProgressBar.transform.scaledBy(x: 2, y: 1.5)
        ProgressBar.layer.cornerRadius = 10
//        ProgressBar.clipsToBounds = true
        
    }
    @IBAction func BotaoNext(_ sender: Any) {
        ProgressBar.progress = 0.2
    }
}


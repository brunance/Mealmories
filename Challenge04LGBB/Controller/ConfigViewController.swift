//
//  ConfigViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 24/08/22.
//

import Foundation
import UIKit

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var touch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch){
        if touch.isOn {
            UserKeys.StatusEye = true
        }else {
            UserKeys.StatusEye = false
        }
    }
}

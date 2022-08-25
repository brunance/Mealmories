//
//  ConfigViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 24/08/22.
//

import Foundation
import UIKit

var teste = false

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var touch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        touch.setOn(defaults.bool(forKey: "Touch"), animated: true)
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch){
        if touch.isOn {
            UserKeys.StatusEye = true
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "Touch")
        }else {
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "Touch")
        }
    }
}

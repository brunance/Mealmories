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
    @IBOutlet weak var soundEffect: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
        let defaults = UserDefaults.standard
        touch.setOn(defaults.bool(forKey: "Touch"), animated: true)
        soundEffect.setOn(defaults.bool(forKey: "Sound"), animated: true)
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
    
    @IBAction func soundSwitchDidChange(_ sender: Any) {
        if soundEffect.isOn {
            UserKeys.StatusSound = true
            let defaults = UserDefaults.standard
            defaults.set(true, forKey: "Sound")
        }else {
            let defaults = UserDefaults.standard
            defaults.set(false, forKey: "Sound")
        }
    }
  
}


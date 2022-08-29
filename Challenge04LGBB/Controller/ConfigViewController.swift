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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let secondVC = segue.destination as! ChosenRecipeViewController
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        secondVC.modalPresentationStyle = .fullScreen
        secondVC.modalTransitionStyle = .crossDissolve
    }
}

//
//  ChoosenRecipeViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit

class ChosenRecipeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var startButton : UIButton!
    
    let transition = CustomTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Recipe" {
            let secondVC = segue.destination as! RecipeViewController
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
        }else if segue.identifier == "Config"{
            let secondVC = segue.destination as! ConfigViewController
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromRight
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startButton.center
        transition.circleColor = UIColor(named: "CorDaview")!
        
        return transition
    }
    
    
}

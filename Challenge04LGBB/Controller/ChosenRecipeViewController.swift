//
//  ChoosenRecipeViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit
import AVFoundation

var soundEffect = false

class ChosenRecipeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var startButton : UIButton!
    var player : AVAudioPlayer?
    let transition = CustomTransition()
    var escolha : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("isso é escolha:\(escolha)")
        let defaults = UserDefaults.standard
        soundEffect = defaults.bool(forKey: "Sound")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Recipe" {
            let secondVC = segue.destination as! RecipeViewController
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
            secondVC.escolha = escolha
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
    
    @IBAction func playSound(_ sender: Any){
        if soundEffect == true {
            if let player = player, player.isPlaying {
                
            } else {
                
                let urlString = Bundle.main.path(forResource: "iniciar-receita", ofType: "mp3")
                
                do {
                    
                    try? AVAudioSession.sharedInstance().setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                    
                    guard let urlString = urlString else {
                        return
                    }
                    
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    
                    guard let player = player else {
                        return
                    }
                    
                    player.play()
                }
                catch {
                    print("Something went wrong! :(")
                }
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startButton.center
        transition.circleColor = UIColor(named: "CorDaview")!
        
        return transition
    }
    
    
}

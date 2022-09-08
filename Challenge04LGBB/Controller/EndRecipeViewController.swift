//
//  EndRecipe.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit

class EndRecipeViewController: UIViewController {
    
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var labelDesbloqueio: UILabel!
    var escolha = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Return" {
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
    
    func setupLabel() {
        let receita = getRecipes()
        labelDesbloqueio.text = receita[escolha].tituloReceita
    }
}

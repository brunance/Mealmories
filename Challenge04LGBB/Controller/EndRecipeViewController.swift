//
//  EndRecipe.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit
import AVFoundation

class EndRecipeViewController: UIViewController {
    
    @IBOutlet weak var ImageMedalha: UIImageView!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var labelDesbloqueio: UILabel!
    var escolha = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppDelegate.AppUtility.lockOrientation(.all)
        setupLabel()
    }
    
    func setupLabel(){
        let receitas = getRecipes()
        labelDesbloqueio.text = receitas[escolha].tituloReceita.localize()
        ImageMedalha.isAccessibilityElement = true
        ImageMedalha.accessibilityLabel = "Imagem da medalha ganha por terminar a receita!"
    }
    
    @IBAction func BackTorecipesScreen(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ListRecipesScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "recipesScreen") as! ListRecipesViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
}

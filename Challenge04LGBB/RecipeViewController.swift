//
//  RecipeViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 16/08/22.
//

import Foundation
import UIKit

class RecipeViewController: UIViewController{
    
    var recipes : [Recipe] = []
    
    override func viewDidLoad() {
        recipes = [
            Recipe(tituloReceita: "Pão de Queijo", numeroIntrucoes: 9, pessoaTurno: ["Adulto, Criança, Mix, Adulto, Mix, Criança, Mix, Adulto, Adulto"], descricaoReceita: ["Em uma vasilha, junte os ingredientes secos: polvilho doce, o parmesão", "misture bem com uma colher ou com a mão!", "Adicione o creme de leite, aos poucos, misturando com as mãos até formar uma massa homogênea e firme.","Retire porções pequenas da massa", "modele do formato que quiser, bolinhas, dadinhos, seja criativo!", "Unte uma fôrma com manteiga e trigo, papel manteiga ou spray de untar ", "Coloque uma ao lado da outra na fôrma grande untada", "Leve ao forno alto, preaquecido, por 15 minutos ou até dourar.", "Retire e sirva em seguida."], numeroEtapas: 3)
        ]
    }
}

//
//  RecipeView.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 16/08/22.
//

import Foundation
import UIKit

class Recipe {
    var tituloReceita: String
    var numeroIntrucoes: Int
    var descricaoReceita : [String]
    var pessoaTurno: [String]
    var numeroEtapas: Int
    var imagemIntrucao: UIImage
    
    init(tituloReceita: String, numeroIntrucoes: Int, pessoaTurno: [String], descricaoReceita: [String], numeroEtapas: Int, imagemIntrucao: UIImage){
        self.tituloReceita = tituloReceita
        self.numeroIntrucoes = numeroIntrucoes
        self.pessoaTurno = pessoaTurno
        self.descricaoReceita = descricaoReceita
        self.numeroEtapas = numeroEtapas
        self.imagemIntrucao = imagemIntrucao
    }
    
    init(){
        self.tituloReceita = ""
        self.numeroIntrucoes = 0
        self.pessoaTurno = [""]
        self.descricaoReceita = [""]
        self.numeroEtapas = 0
        self.imagemIntrucao = UIImage()
    }
}

import UIKit
import Foundation

class ChosenRecipeModel {
    var imagemReceita : UIImage
    var nomeDaReceita  : String
    var tempoDePreparo  : String
    var dificuldade : String
    var idadeRecomendada: Int
    var ingredientes : [String]
    var etapas : [String]
    
    
    init(imagemReceita : UIImage,nomeDaReceita : String,tempoDePreparo : String,dificuldade : String,idadeRecomendada : Int,ingredientes : [String],etapas : [String]){
        self.imagemReceita = imagemReceita
        self.nomeDaReceita = nomeDaReceita
        self.tempoDePreparo = tempoDePreparo
        self.dificuldade = dificuldade
        self.idadeRecomendada = idadeRecomendada
        self.ingredientes = ingredientes
        self.etapas = etapas
    }
    init() {
        self.imagemReceita = UIImage(named: "imagePlaceholder")!
        self.nomeDaReceita = ""
        self.tempoDePreparo = ""
        self.dificuldade = ""
        self.idadeRecomendada = 0
        self.ingredientes = []
        self.etapas = []
    }
}

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
func getChoosenRecipe() -> [ChosenRecipeModel]{
    var ChosenRecipe : [ChosenRecipeModel] = []
    return [ChosenRecipeModel(imagemReceita: UIImage(named: "imagePlaceholder")!, nomeDaReceita: "Pão de Queijo", tempoDePreparo: "30 min", dificuldade: "Facil", idadeRecomendada: 4, ingredientes: ["400g Polvilho doce ou de sua preferência","400g de queijo parmesão ralado","2 caixas de creme de leite (400g) (aproximadamente)","Para untar: manteiga e trigo, spray untador, papel manteiga ou óleo."], etapas: ["Preparo da Massa","Preparo das Formas","Finalizar Preparo"]),ChosenRecipeModel(imagemReceita: UIImage(named: "imagePlaceholder")!, nomeDaReceita: "Pipoca", tempoDePreparo: "10 min", dificuldade: "Facil", idadeRecomendada: 3, ingredientes: ["Pipoca","sal","manteiga","oleo"], etapas: ["juntar","Misturar"])]
}

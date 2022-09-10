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
    var imagemIntrucao: [UIImage]
    var CorDaTela: [UIColor]
    var dicas: [String]
    var CorDoFundoDatela:[UIColor]
    var CorDasEtapas:[UIColor]
    var Etapa:[String]
    var InstruçõesPorEtapa:[Int]
    var auxiliarInstrucoesPorEtapas:[Int]
    
    
    init(tituloReceita: String, numeroIntrucoes: Int, pessoaTurno: [String], descricaoReceita: [String], numeroEtapas: Int, imagemIntrucao: [UIImage],CorDaTela: [UIColor],dicas: [String],CorDoFundoDatela: [UIColor],CorDasEtapas: [UIColor],Etapa:[String],InstruçõesPorEtapa:[Int],auxiliarInstrucoesPorEtapas:[Int]){
        self.tituloReceita = tituloReceita
        self.numeroIntrucoes = numeroIntrucoes
        self.pessoaTurno = pessoaTurno
        self.descricaoReceita = descricaoReceita
        self.numeroEtapas = numeroEtapas
        self.imagemIntrucao = imagemIntrucao
        self.CorDaTela = CorDaTela
        self.dicas = dicas
        self.CorDoFundoDatela = CorDoFundoDatela
        self.CorDasEtapas = CorDasEtapas
        self.Etapa = Etapa
        self.InstruçõesPorEtapa = InstruçõesPorEtapa
        self.auxiliarInstrucoesPorEtapas = auxiliarInstrucoesPorEtapas
        
    }
    
    init(){
        self.tituloReceita = ""
        self.numeroIntrucoes = 0
        self.pessoaTurno = [""]
        self.descricaoReceita = [""]
        self.numeroEtapas = 0
        self.imagemIntrucao = []
        self.CorDaTela = []
        self.dicas = []
        self.CorDoFundoDatela = []
        self.CorDasEtapas = []
        self.Etapa = []
        self.InstruçõesPorEtapa = []
        self.auxiliarInstrucoesPorEtapas = []
    }
}

func getRecipes() -> [Recipe]{
    var recipes : [Recipe] = []
    recipes = [Recipe(tituloReceita: "Pão de Queijo",
                      numeroIntrucoes: 9,
                      pessoaTurno: ["Adulto", "Criança", "Mix", "Adulto", "Mix", "Criança", "Mix", "Adulto", "Adulto"],
                      descricaoReceita: ["Em uma vasilha, junte os ingredientes secos: polvilho doce, e parmesão.", "Misture bem com uma colher ou com a mão!", "Adicione o creme de leite, misturando com as mãos até formar uma massa homogênea e firme.","Retire porções pequenas da massa.", "Modele do formato que quiser, bolinhas, dadinhos, seja criativo!", "Unte uma fôrma com manteiga e trigo, papel manteiga ou spray de untar.", "Coloque as massas modeladas ao lado da outra na fôrma untada.", "Leve ao forno alto, preaquecido a 180°C , por 15 minutos ou até dourar.", "Retire e sirva em seguida."], numeroEtapas: 3,
                      imagemIntrucao:
                        [UIImage(named: "secos.1")!
                         ,UIImage(named: "mistura.1")!
                         ,UIImage(named: "liquidoemistura.1")!
                         ,UIImage(named: "porcoes.1")!
                         ,UIImage(named: "modelagem.1")!
                         ,UIImage(named: "untarforma.1")!
                         ,UIImage(named: "Organizarnaforma.1")!
                         ,UIImage(named: "forno.1")!,
                         UIImage(named: "paodequeijo.1")!]
                      ,CorDaTela: [UIColor(named: "Adulto_Blue")!,UIColor(named: "Child_Orange")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Adulto_Blue")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Child_Orange")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Adulto_Blue")!,UIColor(named: "Adulto_Blue")!],dicas: ["Qualquer tipo de polvilho é bem-vindo, variando de acordo com o seu gosto.","","Para não perder o ponto da massa, adicione creme de leite aos poucos.","","","Pode haver ajuda do adulto na orientação, mas é interessante que a criança faça sozinha.","Deixe sempre um pequeno espaço entre as massas, pode facilitar na hora de retirar os pães.","",""],
                      CorDoFundoDatela: [UIColor(named: "LabelBlue")!,UIColor(named: "LabelOrange")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelBlue")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelOrange")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelBlue")!,UIColor(named: "LabelBlue")!],
                      CorDasEtapas: [UIColor(named: "Adulto_DarkBlue")!,UIColor(named: "Child_DarkOrange")!,UIColor(named: "Mix_DarkMagenta")!,UIColor(named: "Adulto_DarkBlue")!,UIColor(named: "Mix_DarkMagenta")!,UIColor(named: "Child_DarkOrange")!,UIColor(named: "Mix_DarkMagenta")!,UIColor(named: "Adulto_DarkBlue")!,UIColor(named: "Adulto_DarkBlue")!],
                      Etapa: ["Preparo da massa","Preparo da massa","Preparo da massa","Preparo das formas","Preparo das formas","Finalizar preparo","Finalizar preparo","Finalizar preparo","Finalizar preparo"],
                      InstruçõesPorEtapa: [1,1,1,1,1,1,1,1,1],
                      auxiliarInstrucoesPorEtapas: [1,2,3,4,5,6,7,8,9]),
               
               Recipe(tituloReceita: "Pipoca",
                      numeroIntrucoes: 6,
                      pessoaTurno: ["Criança", "Mix", "Criança","Adulto", "Mix", "Adulto"],
                      descricaoReceita: ["Em uma tigela de vidro, adicione o milho para pipoca e sal.", "Adicione as colheres de água e misture", "Cubra com um filme plástico", "Faça 4 furos com garfo", "Coloque por 4 minutos no micro-ondas", "Retire a pipoca do micro-ondas"], numeroEtapas: 2,
                      imagemIntrucao:
                        [UIImage(named: "age-32px")!,UIImage(named: "age-32px")!,UIImage(named: "age-32px")!,UIImage(named: "age-32px")!,UIImage(named: "age-32px")!,UIImage(named: "age-32px")!]
                      ,CorDaTela: [UIColor(named: "Child_Orange")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Child_Orange")!,UIColor(named: "Adulto_Blue")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Adulto_Blue")!],
                      dicas: ["Esqueceu a quantidade? Verifique-a no ícone do canto superior direito da tela!","Esqueceu a quantidade? Verifique-a no ícone do canto superior direito da tela!","","","",""],
                      CorDoFundoDatela: [UIColor(named: "LabelOrange")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelOrange")!,UIColor(named: "LabelBlue")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelBlue")!],
                      CorDasEtapas: [UIColor(named: "Child_DarkOrange")!,UIColor(named: "Mix_DarkMagenta")!,UIColor(named: "Child_DarkOrange")!,UIColor(named: "Adulto_DarkBlue")!,UIColor(named: "Mix_DarkMagenta")!,UIColor(named: "Adulto_DarkBlue")!],
                      Etapa: ["Juntar","Juntar","Cobrir","Cobrir","Micro-ondas","Micro-ondas"],
                      InstruçõesPorEtapa: [1,1,1,1,1,1],
                      auxiliarInstrucoesPorEtapas: [1,2,3,4,5,6])]
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    return recipes
}

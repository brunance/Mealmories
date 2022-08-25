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
    var Etapas:[Int]
    var InstruçõesPorEtapa:[Int]
    var auxiliarInstrucoesPorEtapa:[Int]
    
    init(tituloReceita: String, numeroIntrucoes: Int, pessoaTurno: [String], descricaoReceita: [String], numeroEtapas: Int, imagemIntrucao: [UIImage],CorDaTela: [UIColor],dicas: [String],CorDoFundoDatela: [UIColor],Etapas: [Int],InstruçõesPorEtapa: [Int],auxiliarInstrucoesPorEtapa: [Int]){
        self.tituloReceita = tituloReceita
        self.numeroIntrucoes = numeroIntrucoes
        self.pessoaTurno = pessoaTurno
        self.descricaoReceita = descricaoReceita
        self.numeroEtapas = numeroEtapas
        self.imagemIntrucao = imagemIntrucao
        self.CorDaTela = CorDaTela
        self.dicas = dicas
        self.CorDoFundoDatela = CorDoFundoDatela
        self.Etapas = Etapas
        self.InstruçõesPorEtapa = InstruçõesPorEtapa
        self.auxiliarInstrucoesPorEtapa = auxiliarInstrucoesPorEtapa
        
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
        self.Etapas = []
        self.InstruçõesPorEtapa = []
        self.auxiliarInstrucoesPorEtapa = []
    }
}

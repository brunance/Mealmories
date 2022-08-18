//
//  RecipeDetailViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 16/08/22.
//

import Foundation
import UIKit

var count = 0

class RecipeViewController: UIViewController{
    
    var recipes : [Recipe] = []
        
    @IBOutlet weak var labelIntrucao: UILabel!
    @IBOutlet weak var imagemIntrucao: UIImageView!
    @IBOutlet weak var labelTurno: UILabel!
    @IBOutlet weak var labelImagem: UILabel!
    @IBOutlet weak var viewTurno: UIView!
    @IBOutlet weak var labelContagemTurno: UILabel!

    @IBOutlet weak var statusbar: UIView!
    
    @IBOutlet weak var LabelDica: UILabel!
    override func viewDidLoad() {
        viewTurno.layer.cornerRadius = 15
        viewTurno.layer.borderWidth = 5
        print("view atrualizada")
        recipes = [
            Recipe(tituloReceita: "Pão de Queijo", numeroIntrucoes: 9, pessoaTurno: ["Adulto", "Criança", "Mix", "Adulto", "Mix", "Criança", "Mix", "Adulto", "Adulto"], descricaoReceita: ["Em uma vasilha, junte os ingredientes secos: polvilho doce, e parmesão", "misture bem com uma colher ou com a mão!", "Adicione o creme de leite, aos poucos, misturando com as mãos até formar uma massa homogênea e firme.","Retire porções pequenas da massa", "modele do formato que quiser, bolinhas, dadinhos, seja criativo!", "Unte uma fôrma com manteiga e trigo, papel manteiga ou spray de untar ", "Coloque uma ao lado da outra na fôrma grande untada", "Leve ao forno alto, preaquecido, por 15 minutos ou até dourar.", "Retire e sirva em seguida."], numeroEtapas: 3, imagemIntrucao: UIImage(named: "imagePlaceholder")!,CorDaTela: [UIColor(named: "Adulto_Blue")!,UIColor.orange,UIColor.red,UIColor(named: "Adulto_Blue")!,UIColor.red,UIColor.orange,UIColor.red,UIColor(named: "Adulto_Blue")!,UIColor(named: "Adulto_Blue")!],dicas: ["Qualquer dos dois tipos de polvilhos são bem-vindos, variando de acordo com o gosto de quem manuseia a receita","","É necessário que o creme de leite seja adicionado aos poucos, para não perder o ponto da massa.","","É necessário que o creme de leite seja adicionado aos poucos, para não perder o ponto da massa.","Pode haver ajuda do adulto na orientação, mas é interessante que a criança faça sozinha.","Deixe sempre um pequeno espaço entre, pode facilitar na hora de retirar os pães.","Deixe por 15 minutos ou até dourar",""])
        ]
        labelTurno.text = "Turno \(recipes[0].pessoaTurno[count])"
        labelIntrucao.text = "\(recipes[0].descricaoReceita[count])"
        LabelDica.text = "\(recipes[0].dicas[count])"
        navigationController?.navigationBar.backgroundColor = recipes[0].CorDaTela[count]
        statusbar.backgroundColor = recipes[0].CorDaTela[count]
        viewTurno.layer.borderColor = recipes[0].CorDaTela[count].cgColor
       
       
    }
    @IBAction func SwipeLeft(_ sender: Any) {
        count += 1
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
        

        let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromRight
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
    
    @IBAction func SwipeRight(_ sender: Any) {
        count -= 1
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
        

        let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromLeft
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
}

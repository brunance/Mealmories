import Foundation
import UIKit

class RecipesViewController : UIViewController{
    @IBOutlet weak var confete: UIImageView!
    //Outlets da receita de destaque
    @IBOutlet weak var FundoCards: UIView!
    @IBOutlet weak var TimeCard: UILabel!
    @IBOutlet weak var difficultyCard: UILabel!
    @IBOutlet weak var AgeCard: UILabel!
    @IBOutlet weak var NameCard: UILabel!
    @IBOutlet weak var ImageCard: UIImageView!
    var escolha : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        FundoCards.layer.borderColor = UIColor(named: "Mix_Magenta")!.cgColor
        FundoCards.layer.borderWidth = 3
        confete.layer.opacity = 0.4
        SetReceitaDestaque()
    }
    
    func SetReceitaDestaque() {
       var receitaDeDestaque =  getChoosenRecipe()
        TimeCard.text = "\(receitaDeDestaque[0].tempoDePreparo)"
        difficultyCard.text = "\(receitaDeDestaque[0].dificuldade)"
        AgeCard.text = "+\(receitaDeDestaque[0].idadeRecomendada) anos"
        NameCard.text = "\(receitaDeDestaque[0].nomeDaReceita)"
        ImageCard.image = receitaDeDestaque[0].imagemReceita
        
    }
  
    @IBAction func ClickReceitaDestaque(_ sender: Any) {
        escolha = 0
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let escolha = escolha
        let destination = segue.destination as! ChosenRecipeViewController
        destination.escolha = escolha
    }
}

import Foundation
import UIKit

class RecipesViewController : UIViewController,UITableViewDataSource,UITableViewDelegate{
 
    
    @IBOutlet weak var confete: UIImageView!
    //Outlets da receita de destaque
    @IBOutlet weak var FundoCards: UIView!
    @IBOutlet weak var TimeCard: UILabel!
    @IBOutlet weak var difficultyCard: UILabel!
    @IBOutlet weak var AgeCard: UILabel!
    @IBOutlet weak var NameCard: UILabel!
    @IBOutlet weak var ImageCard: UIImageView!
    
    //Outlets das Receitas Rapidas
    @IBOutlet weak var tablleViewReceitasRapidas: UITableView!
    
    var escolha : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        tablleViewReceitasRapidas.dataSource = self
        tablleViewReceitasRapidas.delegate = self
       
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
        PassingToChoosenRecipe()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipes = getChoosenRecipe()
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipes = getChoosenRecipe()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.ImageTabbleView.image = recipes[indexPath.row].imagemReceita
        cell.nameTableView.text = "\(recipes[indexPath.row].nomeDaReceita)"
        cell.AgeTableView.text = "+\(recipes[indexPath.row].idadeRecomendada) anos"
        cell.dificultyTableView.text = "\(recipes[indexPath.row].dificuldade)"
        cell.timeTableView.text = "\(recipes[indexPath.row].tempoDePreparo)"
        return cell
    }
    
    func PassingToChoosenRecipe() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ChosenRecipe", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChosenRecipe") as! ChosenRecipeViewController
        
        let transition = CATransition()
        transition.type = CATransitionType.fade
        
        let escolha = escolha
        newViewController.escolha = escolha
        
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
   

}

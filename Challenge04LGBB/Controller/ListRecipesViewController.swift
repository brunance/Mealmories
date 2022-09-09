import Foundation
import UIKit

class ListRecipesViewController : UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    
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
    
    let randomInt = Int.random(in: 0..<2)
    // 2 é o numero total de receitas
    override func viewDidLoad() {
        super.viewDidLoad()
        BackBarButton()
        tablleViewReceitasRapidas.dataSource = self
        tablleViewReceitasRapidas.delegate = self
        FundoCards.layer.borderColor = UIColor(named: "Mix_Magenta")!.cgColor
        FundoCards.layer.borderWidth = 3
        confete.layer.opacity = 0.4
        SetReceitaDestaque()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    func BackBarButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func SetReceitaDestaque() {
        
        let receitaDeDestaque =  getChoosenRecipe()
        
        TimeCard.text = "\(receitaDeDestaque[randomInt].tempoDePreparo)"
        difficultyCard.text = "\(receitaDeDestaque[randomInt].dificuldade)"
        AgeCard.text = "+\(receitaDeDestaque[randomInt].idadeRecomendada) anos"
        NameCard.text = "\(receitaDeDestaque[randomInt].nomeDaReceita)"
        ImageCard.image = receitaDeDestaque[randomInt].imagemReceita
        
    }
    
    @IBAction func ClickReceitaDestaque(_ sender: Any) {
        escolha = randomInt
        navigation()
        
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
        cell.selectionStyle = .none
        return cell
    }
    
    func navigation() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ChosenRecipe", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChosenRecipe") as! ChosenRecipeViewController
        
        let escolha = escolha
        newViewController.escolha = escolha
        
        self.navigationController?.pushViewController(newViewController, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        escolha = indexPath.row
        navigation()
    }
    
    
}
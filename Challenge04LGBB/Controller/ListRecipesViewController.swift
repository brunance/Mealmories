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
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
        BackBarButton()
        tablleViewReceitasRapidas.dataSource = self
        tablleViewReceitasRapidas.delegate = self
        FundoCards.layer.borderColor = UIColor(named: "Mix_Magenta")!.cgColor
        FundoCards.layer.borderWidth = 3
        confete.layer.opacity = 0.4
        SetReceitaDestaque()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        let appearence = UINavigationBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.shadowColor = .clear
        appearence.backgroundColor = .clear
        appearence.backgroundImage = nil
        appearence.shadowImage = nil
        self.navigationController?.navigationBar.standardAppearance = appearence

    }
    func BackBarButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func SetReceitaDestaque() {
        
        let receitaDeDestaque =  getChoosenRecipe()
        
        TimeCard.text = "\(receitaDeDestaque[randomInt].tempoDePreparo)".localize()
        difficultyCard.text = "\(receitaDeDestaque[randomInt].dificuldade)".localize()
        AgeCard.text = "+\(receitaDeDestaque[randomInt].idadeRecomendada) anos".localize()
        NameCard.text = "\(receitaDeDestaque[randomInt].nomeDaReceita)".localize()
        ImageCard.image = receitaDeDestaque[randomInt].imagemReceita
        ImageCard.isAccessibilityElement = true
        ImageCard.accessibilityLabel = "Imagem da receita em destaque, \(receitaDeDestaque[randomInt].nomeDaReceita)"
    }
    
    @IBAction func ClickReceitaDestaque(_ sender: Any) {
        escolha = randomInt
        navigation(destino: "Chosen")
        
    }
    
    @IBAction func ConfigButton(_ sender: Any) {
        navigation(destino: "Config")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipes = getChoosenRecipe()
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipes = getChoosenRecipe()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.ImageTabbleView.image = recipes[indexPath.row].imagemReceita
        cell.nameTableView.text = "\(recipes[indexPath.row].nomeDaReceita)".localize()
        cell.AgeTableView.text = "+\(recipes[indexPath.row].idadeRecomendada) anos".localize()
        cell.dificultyTableView.text = "\(recipes[indexPath.row].dificuldade)".localize()
        cell.timeTableView.text = "\(recipes[indexPath.row].tempoDePreparo)".localize()
        cell.selectionStyle = .none
        return cell
    }
    
    func navigation(destino: String) {
        if destino == "Chosen" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ChosenRecipe", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChosenRecipe") as! ChosenRecipeViewController
            
            let escolha = escolha
            newViewController.escolha = escolha
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        if destino == "Config" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ConfigScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfigScreen") as! ConfigViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        escolha = indexPath.row
        navigation(destino: "Chosen")
    }
    
    
}



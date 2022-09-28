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
    
    @IBOutlet weak var ScrollRecipesHeight: NSLayoutConstraint!
    //Outlets das Receitas Rapidas
    @IBOutlet weak var tablleViewReceitasRapidas: UITableView!
    @IBOutlet weak var tableViewReceitasRapidasHeight: NSLayoutConstraint!
    
    var escolha : Int = -1
    
    let randomInt = Int.random(in: 0..<4)
    // 2 é o numero total de receitas
    override func viewDidLoad() {
        super.viewDidLoad()
        notifications()
        self.navigationController?.navigationBar.tintColor = UIColor.label
        
        BackBarButton()
        tablleViewReceitasRapidas.dataSource = self
        tablleViewReceitasRapidas.delegate = self
        FundoCards.layer.borderColor = UIColor(named: "Mix_Magenta")!.cgColor
        FundoCards.layer.borderWidth = 3
        confete.layer.opacity = 0.4
        SetReceitaDestaque()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
        self.navigationController?.isNavigationBarHidden = false
        let appearence = UINavigationBarAppearance()
        appearence.configureWithTransparentBackground()
        appearence.shadowColor = .clear
        appearence.backgroundColor = .clear
        appearence.backgroundImage = nil
        appearence.shadowImage = nil
        self.navigationController?.navigationBar.standardAppearance = appearence
        
    }
    
    override func viewWillLayoutSubviews() {
        self.tableViewReceitasRapidasHeight.constant += self.tablleViewReceitasRapidas.contentSize.height + 100
        self.ScrollRecipesHeight.constant += self.tableViewReceitasRapidasHeight.constant / 2
    }
    func notifications(){
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
        
        //notificacao 1
        
        
        let content = UNMutableNotificationContent()
        content.title = "Vamos Cozinhar"
        content.body = "É hora de cozinhar em conjunto"
        
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.weekday = 4
        dateComponents.hour = 11
        dateComponents.minute = 41
        
           
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

       
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
           }
        }
//        let content2 = UNMutableNotificationContent()
//        content2.title = "Weekly Staff Meeting"
//        content2.body = "Every Tuesday at 2pm"
//
//
//        var dateComponents2 = DateComponents()
//        dateComponents2.calendar = Calendar.current
//
//        dateComponents2.weekday = 4
//        dateComponents2.hour = 11
//        dateComponents2.minute = 20
//
//
//        let trigger2 = UNCalendarNotificationTrigger(
//                 dateMatching: dateComponents2, repeats: true)
//
//        let uuidString2 = UUID().uuidString
//        let request2 = UNNotificationRequest(identifier: uuidString2,
//                    content: content2, trigger: trigger2)
//
//
//        let notificationCenter2 = UNUserNotificationCenter.current()
//        notificationCenter2.add(request2) { (error) in
//           if error != nil {
//           }
//        }
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



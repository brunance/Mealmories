import Foundation
import UIKit
import NotificationCenter


class ListRecipesViewController : UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var confetti: UIImageView!
    //Outlets da receita de destaque
    @IBOutlet weak var fundoCards: UIView!
    @IBOutlet weak var timeCard: UILabel!
    @IBOutlet weak var difficultyCard: UILabel!
    @IBOutlet weak var ageCard: UILabel!
    @IBOutlet weak var nameCard: UILabel!
    @IBOutlet weak var imageCard: UIImageView!
    
    @IBOutlet weak var difficultyCardImage: UIImageView!
    @IBOutlet weak var scrollRecipesHeight: NSLayoutConstraint!
    //Outlets das Receitas Rapidas
    @IBOutlet weak var tableViewReceitasRapidas: UITableView!
    @IBOutlet weak var tableViewReceitasRapidasHeight: NSLayoutConstraint!
    
    var escolha : Int = -1
    
    let randomInt = Int.random(in: 0..<5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifications()
        self.navigationController?.navigationBar.tintColor = UIColor.label
        
        setupNavigationBackButton()
        tableViewReceitasRapidas.dataSource = self
        tableViewReceitasRapidas.delegate = self
        fundoCards.layer.borderColor = UIColor(named: "Mix_Magenta")!.cgColor
        fundoCards.layer.borderWidth = 3
        confetti.layer.opacity = 0.4
        
        self.scrollRecipesHeight.constant += self.tableViewReceitasRapidasHeight.constant - 100
        
        setReceitaDestaque()
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
        let recipes = getChosenRecipe()
        self.tableViewReceitasRapidasHeight.constant = (self.tableViewReceitasRapidas.contentSize.height * CGFloat(recipes.count))
    }
    
    func notifications(){
        
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
        }
      
        let content = UNMutableNotificationContent()
        content.title = "Quais seus planos pra noite?".localize()
        content.body = "Faça uma receita deliciosa em conjunto para criar mais Mealmories.".localize()
        content.sound = .defaultRingtone
        
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        dateComponents.weekday = 4
        dateComponents.hour = 19
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents, repeats: true)
        
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if error != nil {
            }
        }
        
        let content2 = UNMutableNotificationContent()
        content2.title = "Que tal um café da manhã delicioso?".localize()
        content2.body = "Com panquecas coloridas o tudo fica mais divertido! ".localize()
        content2.sound = .defaultRingtone
        
        var dateComponents2 = DateComponents()
        dateComponents2.calendar = Calendar.current
        
        dateComponents2.weekday = 6
        dateComponents2.hour = 10
        
        let trigger2 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents2, repeats: true)
        
        let uuidString2 = UUID().uuidString
        let request2 = UNNotificationRequest(identifier: uuidString2, content: content2, trigger: trigger2)

        let notificationCenter2 = UNUserNotificationCenter.current()
        notificationCenter2.add(request2) { (error) in
            if error != nil {
            }
        }
        
        let content3 = UNMutableNotificationContent()
        content3.title = "Lanche da tarde rápido".localize()
        content3.body = "Uma pipoca? Mini Gelatinas? Brigadeiro? Há vários jeitos de se divertir.".localize()
        content3.sound = .defaultRingtone

        var dateComponents3 = DateComponents()
        dateComponents3.calendar = Calendar.current
        
        dateComponents3.weekday = 6
        dateComponents3.hour = 16
        
        let trigger3 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents3, repeats: true)
        
        let uuidString3 = UUID().uuidString
        let request3 = UNNotificationRequest(identifier: uuidString3,content: content3, trigger: trigger3)
        
        let notificationCenter3 = UNUserNotificationCenter.current()
        notificationCenter3.add(request3) { (error) in
            if error != nil {
            }
        }
        let content4 = UNMutableNotificationContent()
        content4.title = "Crie Mealmories para suas manhãs!".localize()
        content4.body = "Faça várias receitas e combine possibilidades pra ter uma refeição única.".localize()
        content4.sound = .defaultRingtone
        
        var dateComponents4 = DateComponents()
        dateComponents4.calendar = Calendar.current
        
        dateComponents4.weekday = 7
        dateComponents4.hour = 10
        
        let trigger4 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents2, repeats: true)
        
        let uuidString4 = UUID().uuidString
        let request4 = UNNotificationRequest(identifier: uuidString4, content: content4, trigger: trigger4)
        
        let notificationCenter4 = UNUserNotificationCenter.current()
        notificationCenter4.add(request4) { (error) in
            if error != nil {
            }
        }
        
        let content5 = UNMutableNotificationContent()
        content5.title = "Que tal um filme e bastante comida?".localize()
        content5.body = "Venha fazer as receitas mais gostosas e divertidas com quem ama, combine todas e faça um grande lanche! ".localize()
        content5.sound = .defaultRingtone
        
        var dateComponents5 = DateComponents()
        dateComponents5.calendar = Calendar.current
        
        dateComponents5.weekday = 7
        dateComponents5.hour = 16
        
        let trigger5 = UNCalendarNotificationTrigger(
            dateMatching: dateComponents5, repeats: true)
        
        let uuidString5 = UUID().uuidString
        let request5 = UNNotificationRequest(identifier: uuidString5,
                                             content: content5, trigger: trigger5)
        
        let notificationCenter5 = UNUserNotificationCenter.current()
        notificationCenter5.add(request5) { (error) in
            if error != nil {
            }
        }
    }
    
    func setupNavigationBackButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func setReceitaDestaque() {
        
        let receitaDeDestaque =  getChosenRecipe()
        
        timeCard.text = "\(receitaDeDestaque[randomInt].tempoDePreparo)".localize()
        difficultyCard.text = "\(receitaDeDestaque[randomInt].dificuldade)".localize()
        ageCard.text = "+\(receitaDeDestaque[randomInt].idadeRecomendada) anos".localize()
        nameCard.text = "\(receitaDeDestaque[randomInt].nomeDaReceita)".localize()
        imageCard.image = receitaDeDestaque[randomInt].imagemReceita
        imageCard.isAccessibilityElement = true
        imageCard.accessibilityLabel = "Imagem da receita em destaque, \(receitaDeDestaque[randomInt].nomeDaReceita)"
        difficultyCardImage.image = UIImage(named: "\(receitaDeDestaque[randomInt].dificuldade)-32px")
        
    }
    
    @IBAction func ClickReceitaDestaque(_ sender: Any) {
        escolha = randomInt
        navigation(destino: .chosen)
        
    }
    
    @IBAction func ConfigButton(_ sender: Any) {
        navigation(destino: .config)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let recipes = getChosenRecipe()
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipes = getChosenRecipe()
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipesTableViewCell
        cell.imageTableView.image = recipes[indexPath.row].imagemReceita
        cell.nameTableView.text = "\(recipes[indexPath.row].nomeDaReceita)".localize()
        cell.ageTableView.text = "+\(recipes[indexPath.row].idadeRecomendada) anos".localize()
        cell.dificultyTableView.text = "\(recipes[indexPath.row].dificuldade)".localize()
        cell.timeTableView.text = "\(recipes[indexPath.row].tempoDePreparo)".localize()
        cell.dificultyImageView.image = UIImage(named: "\(recipes[indexPath.row].dificuldade)-16px")
        cell.selectionStyle = .none
        return cell
    }
    
    func navigation(destino: Destinations) {
        if destino == .chosen {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ChosenRecipe", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ChosenRecipe") as! ChosenRecipeViewController
            
            let escolha = escolha
            newViewController.escolha = escolha
            
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        if destino == .config {
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
        navigation(destino: .chosen)
    }

}



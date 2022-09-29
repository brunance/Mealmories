//
//  ChoosenRecipeViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit
import AVFoundation

var soundEffect = false
var hapticEffect = false

class ChosenRecipeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var tableIngredients: UITableView!
    @IBOutlet weak var tableIngredientsHeight: NSLayoutConstraint!
    @IBOutlet weak var tableEtapas: UITableView!
    @IBOutlet weak var tableEtapasHeight: NSLayoutConstraint!
    @IBOutlet weak var ScrollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ImagemReceitaEscolhida: UIImageView!
    
    @IBOutlet weak var nomeReceitaEscolhida: UILabel!
    @IBOutlet weak var tempoReceitaEscolhida: UILabel!
    @IBOutlet weak var dificultyReceitaEscolhida: UILabel!
    @IBOutlet weak var dificultyReceitaEscolhidaImage: UIImageView!
    @IBOutlet weak var AgeReceitaEscolhida: UILabel!
    
    var itemList1 : [String] = [String]()
    var itemList2 : [String] = [String]()
    var choosenrecipe : [ChosenRecipeModel] = []
    
    @IBOutlet weak var startButton : UIButton!
    
    var player : AVAudioPlayer?
    var escolha : Int = 0
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackBarButton()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.rightBarButtonItem?.isAccessibilityElement = true
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Botão de configurações de som e interação sem toque"
        SetChoosenRecipe()
        startButton.layer.cornerRadius = 20
        self.setTableView()
        if choosenrecipe[escolha].ingredientes.count >= 5 {
            self.ScrollViewHeight.constant += self.tableIngredients.contentSize.height - 260.0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
        print("papa Som:\(UserKeys.StatusSound)")
        print("papa Olho:\(UserKeys.StatusEye)")
        let defaults = UserDefaults.standard
        soundEffect = defaults.bool(forKey: "Sound")
        hapticEffect = defaults.bool(forKey: "Haptic")

    }
    
    private func setTableView(){
        self.tableIngredients.delegate = self
        self.tableIngredients.dataSource = self
        self.tableIngredients.register(UINib(nibName: "TableIngredientCell", bundle: nil), forCellReuseIdentifier: "TableIngredientCell")
        self.tableIngredients.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        self.tableEtapas.delegate = self
        self.tableEtapas.dataSource = self
        self.tableEtapas.register(UINib(nibName: "TableEtapasCell", bundle: nil), forCellReuseIdentifier: "TableEtapasCell")
        self.tableEtapas.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.setTabeleViewData()
    }
    
    override func viewWillLayoutSubviews() {
        self.tableIngredientsHeight.constant = self.tableIngredients.contentSize.height
        self.tableEtapasHeight.constant = self.tableEtapas.contentSize.height
        
    }
    
    private func setTabeleViewData(){
        choosenrecipe = getChoosenRecipe()
        for i in 0...choosenrecipe[escolha].ingredientes.count - 1 {
            self.itemList1.append(choosenrecipe[escolha].ingredientes[i])
        }
        for i in 0...choosenrecipe[escolha].etapas.count - 1 {
            self.itemList2.append(choosenrecipe[escolha].etapas[i])
        }
        
        self.tableIngredients.reloadData()
        self.tableEtapas.reloadData()
        self.tableIngredients.invalidateIntrinsicContentSize()
        self.tableEtapas.invalidateIntrinsicContentSize()
    }
    
    @IBAction func configbutton(_ sender: Any) {
        navigation(destino: "Config")
    }
    
    func BackBarButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func navigation(destino:String){
        if destino == "Recipe" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
            
            let escolha = escolha
            newViewController.escolha = escolha
            let count = count
            newViewController.count = 0
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        if destino == "Config" {
            let storyBoard: UIStoryboard = UIStoryboard(name: "ConfigScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ConfigScreen") as! ConfigViewController
            
            self.navigationController?.pushViewController(newViewController, animated: true)
            
        }
        
    }
    
    
    
    @IBAction func playSound(_ sender: Any){
        navigation(destino: "Recipe")
        if hapticEffect == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        if soundEffect == true {
            if let player = player, player.isPlaying {
                
            } else {
                
                let urlString = Bundle.main.path(forResource: "iniciar-receita", ofType: "mp3")
                
                do {
                    
                    try? AVAudioSession.sharedInstance().setMode(.default)
                    try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                    
                    guard let urlString = urlString else {
                        return
                    }
                    
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                    
                    guard let player = player else {
                        return
                    }
                    
                    player.play()
                }
                catch {
                    print("Something went wrong! :(")
                }
            }
        }
    }
    
    
    func SetChoosenRecipe()  {
        let chossenRecipe = getChoosenRecipe()
        ImagemReceitaEscolhida.image = chossenRecipe[escolha].imagemReceita
        ImagemReceitaEscolhida.isAccessibilityElement = true
        ImagemReceitaEscolhida.accessibilityLabel = "Imagem da Receita Escolhida, \(chossenRecipe[escolha].nomeDaReceita)"
        nomeReceitaEscolhida.text = "\(chossenRecipe[escolha].nomeDaReceita)".localize()
        nomeReceitaEscolhida.accessibilityLabel = "Nome da Receita Escolhida, \(chossenRecipe[escolha].nomeDaReceita)"
        tempoReceitaEscolhida.text = "\(chossenRecipe[escolha].tempoDePreparo)".localize()
        tempoReceitaEscolhida.accessibilityLabel = "Tempo estimado de duração da receita escolhida, \(chossenRecipe[escolha].tempoDePreparo)"
        dificultyReceitaEscolhida.text = "\(chossenRecipe[escolha].dificuldade)".localize()
        dificultyReceitaEscolhida.accessibilityLabel = "Dificuldade da receita escolhida, \(chossenRecipe[escolha].dificuldade)"
        dificultyReceitaEscolhidaImage.image = UIImage(named: "\(chossenRecipe[escolha].dificuldade)-32px")
        AgeReceitaEscolhida.text = "+ \(chossenRecipe[escolha].idadeRecomendada) anos".localize()
        AgeReceitaEscolhida.accessibilityLabel = "Faixa etária da receita escolhida, \(chossenRecipe[escolha].idadeRecomendada) anos ou mais"
    }
    
    
}

class TableIngredientCell2: UITableViewCell{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var LabelCell: UILabel!
}

class TableEtapasCell2: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageEtapaCell: UIImageView!
    @IBOutlet weak var labelEtapaCell: UILabel!
}

extension ChosenRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        if tableView == self.tableIngredients {
            count = self.itemList1.count
        }
        
        if tableView == self.tableEtapas {
            count = self.itemList2.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.tableIngredients{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableIngredientCell
            
            cell.LabelCell.text = self.itemList1[indexPath.item].localize()
            cell.bgView.backgroundColor = UIColor(named: "LabelMagenta")
            cell.imageCell.image = UIImage(named: "ingrediente")
            
            return cell
        }
        
        if tableView == self.tableEtapas{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TableEtapasCell
            
            cell.labelEtapaCell.text = self.itemList2[indexPath.item].localize()
            cell.backView.backgroundColor = UIColor(named: "LabelOrange")
            cell.imageEtapaCell.image = UIImage(named: "Numero \(indexPath.item + 1)")
            
            return cell
        }
        
        return cell!
    }
}



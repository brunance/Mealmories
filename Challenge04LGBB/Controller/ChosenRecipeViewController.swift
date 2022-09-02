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

class ChosenRecipeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    @IBOutlet weak var tableIngredients: UITableView!
    @IBOutlet weak var tableIngredientsHeight: NSLayoutConstraint!
    @IBOutlet weak var tableEtapas: UITableView!
    @IBOutlet weak var tableEtapasHeight: NSLayoutConstraint!
    
    @IBOutlet weak var ImagemReceitaEscolhida: UIImageView!
    @IBOutlet weak var nomeReceitaEscolhida: UILabel!
    @IBOutlet weak var tempoReceitaEscolhida: UILabel!
    @IBOutlet weak var dificultyReceitaEscolhida: UILabel!
    @IBOutlet weak var AgeReceitaEscolhida: UILabel!
    
    var itemList1 : [String] = [String]()
    var itemList2 : [String] = [String]()
    var choosenrecipe : [ChosenRecipeModel] = []
    
    @IBOutlet weak var startButton : UIButton!
    
    var player : AVAudioPlayer?
    let transition = CustomTransition()
    var escolha : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetChoosenRecipe()
        print("isso é escolha:\(escolha)")
        let defaults = UserDefaults.standard
        soundEffect = defaults.bool(forKey: "Sound")
        self.setTableView()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Recipe" {
            let secondVC = segue.destination as! RecipeViewController
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
            secondVC.escolha = escolha
        }else if segue.identifier == "Config"{
            let secondVC = segue.destination as! ConfigViewController
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromRight
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
        }
        else if segue.identifier == "Back"{
            let secondVC = segue.destination as! RecipesViewController
            
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromLeft
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
        }
        
    }
    
    @IBAction func playSound(_ sender: Any){
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
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = startButton.center
        transition.circleColor = UIColor(named: "CorDaview")!
        
        return transition
    }
    func SetChoosenRecipe()  {
        let chossenRecipe = getChoosenRecipe()
        ImagemReceitaEscolhida.image = chossenRecipe[escolha].imagemReceita
        nomeReceitaEscolhida.text = "\(chossenRecipe[escolha].nomeDaReceita)"
        tempoReceitaEscolhida.text = "\(chossenRecipe[escolha].tempoDePreparo)"
        dificultyReceitaEscolhida.text = "\(chossenRecipe[escolha].dificuldade)"
        AgeReceitaEscolhida.text = "+ \(chossenRecipe[escolha].idadeRecomendada) anos"
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
            
            cell.LabelCell.text = self.itemList1[indexPath.item]
            cell.bgView.backgroundColor = UIColor(named: "LabelMagenta")
            cell.bgView.layer.cornerRadius = 10
            cell.imageCell.image = UIImage(named: "ingrediente")
            
            return cell
        }
        
        if tableView == self.tableEtapas{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! TableEtapasCell
            
            cell.labelEtapaCell.text = self.itemList2[indexPath.item]
            cell.backView.backgroundColor = UIColor(named: "LabelOrange")
            cell.backView.layer.cornerRadius = 10
            cell.imageEtapaCell.image = UIImage(named: "Numero \(indexPath.item + 1)")
            
            return cell
        }
        
        return cell!
    }
}

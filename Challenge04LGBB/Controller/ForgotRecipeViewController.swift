//
//  ForgotRecipeViewController.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 29/08/22.
//

import Foundation
import UIKit

class ForgotRecipeViewController: UIViewController {
    
    @IBOutlet weak var tableIngredients: UITableView!
    @IBOutlet weak var tableIngredientsHeight: NSLayoutConstraint!
    @IBOutlet weak var tableEtapas: UITableView!
    @IBOutlet weak var tableEtapasHeight: NSLayoutConstraint!
    
    private var itemList1 : [String] = [String]()
    private var itemList2 : [String] = [String]()
    
    var choosenrecipe : [ChosenRecipeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        for i in 0...choosenrecipe[0].ingredientes.count - 1 {
            self.itemList1.append(choosenrecipe[0].ingredientes[i])
        }
        for i in 0...choosenrecipe[0].etapas.count - 1 {
            self.itemList2.append(choosenrecipe[0].etapas[i])
        }
        
        self.tableIngredients.reloadData()
        self.tableEtapas.reloadData()
        self.tableIngredients.invalidateIntrinsicContentSize()
        self.tableEtapas.invalidateIntrinsicContentSize()
    }
}

class TableIngredientCell: UITableViewCell{
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var LabelCell: UILabel!
}

class TableEtapasCell :UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageEtapaCell: UIImageView!
    @IBOutlet weak var labelEtapaCell: UILabel!
}

extension ForgotRecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
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

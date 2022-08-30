import Foundation
import UIKit

class RecipesViewController : UIViewController{
    var escolha : Int = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func PaoDeQueijo(_ sender: Any) {
        escolha = 0
       
    }
    @IBAction func Pipoca(_ sender: Any) {
        escolha = 1
      
    }
    @IBAction func MistoQuente(_ sender: Any) {
        escolha = 2
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let escolha = escolha
        let destination = segue.destination as! ChosenRecipeViewController
        destination.escolha = escolha
    }
}

import UIKit
var cont = 0
var turno:[String] = ["adulto","criança","mix","adulto","mix","criança","mix","adulto","adulto"]
class FirstPage: UIViewController {
    @IBOutlet weak var Contador: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cont)
        if turno[cont] == "adulto"{
            view.backgroundColor = UIColor.blue
        }
        else if turno[cont] == "criança"{
            view.backgroundColor = UIColor.orange
        }
        else if turno[cont] == "mix"{
            view.backgroundColor = UIColor.red
        }
        print("a view foi carregada")
        
    }
   
 
    @IBAction func swipeLeft(_ sender: Any) {
        cont += 1
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! FirstPage
        

        let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromRight
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
        
        
    }
    
    
    @IBAction func SwipeRight(_ sender: Any) {
        cont -= 1
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! FirstPage
        

        let transition = CATransition()
            transition.duration = 0.4
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromLeft
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
    


}

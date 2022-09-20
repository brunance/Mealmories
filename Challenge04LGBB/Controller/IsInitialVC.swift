
import Foundation
import UIKit

class IsInitialUser : UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    override func viewDidAppear(_ animated: Bool) {
        if LandscapeManager.shared.isFirstLaunch{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Onboard", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Onboard") as! OnBoardVc
            
            self.navigationController?.pushViewController(newViewController, animated: false)
            
            LandscapeManager.shared.isFirstLaunch = true
        }
        else{
        
            let storyBoard: UIStoryboard = UIStoryboard(name: "ListRecipesScreen", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "recipesScreen") as! ListRecipesViewController
            
            self.navigationController?.pushViewController(newViewController, animated: false)        }
    }
    class LandscapeManager {
        static let shared = LandscapeManager()
        var isFirstLaunch: Bool {
            get {
                !UserDefaults.standard.bool(forKey: #function)
            } set {
                UserDefaults.standard.setValue(newValue, forKey: #function)
            }
        }
    }
}

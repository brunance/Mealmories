

import UIKit

class FirstPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
       
    }
    
    @IBAction func swipeLeft(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "NextPage", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NextPage") as! NextPage
                

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

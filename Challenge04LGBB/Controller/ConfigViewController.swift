
import Foundation
import UIKit
import AVFoundation

var teste = false
var autorizacao = false
var count = 0

class ConfigViewController: UIViewController {
    
    @IBOutlet weak var touch: UISwitch!
    @IBOutlet weak var soundEffect: UISwitch!
    @IBOutlet weak var haptic: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        touch.setOn(defaults.bool(forConfigKey: .touch), animated: true)
        soundEffect.setOn(defaults.bool(forConfigKey: .sound), animated: true)
        haptic.setOn(defaults.bool(forConfigKey: .haptic), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
    }
    
    @IBAction func touchswitch(_ sender: Any) {
        getPermission()
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch){
        if touch.isOn == true {
            UserKeys.StatusEye = true
            let defaults = UserDefaults.standard
            defaults.set(true, forConfigKey: .touch)
        }
        else{
            let defaults = UserDefaults.standard
            defaults.set(false, forConfigKey: .touch)
        }
    }
    
    func presentCameraSettings() {
        let alertController = UIAlertController(title: "Permission Required", message: "You need camera permission to use Touchless Interaction", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default))
        alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url, options: [:] , completionHandler: {
                    _ in
                })
            }
        })
        
        present(alertController, animated: true)
    }
    
    func getPermission(){
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                autorizacao = true
            } else {
                DispatchQueue.main.async{
                    self.touch.setOn(false, animated: false)
                    let defaults = UserDefaults.standard
                    defaults.set(false, forConfigKey: .touch)
                    if count > 0{
                        self.presentCameraSettings()
                    }
                    count += 1
                }
            }
        }
    }
    
    @IBAction func soundSwitchDidChange(_ sender: Any) {
        if soundEffect.isOn {
            UserKeys.StatusSound = true
            let defaults = UserDefaults.standard
            defaults.set(true, forConfigKey: .sound)
        }else {
            let defaults = UserDefaults.standard
            defaults.set(false, forConfigKey: .sound)
        }
    }
    
    @IBAction func hapticSwitchChange(_ sender: Any) {
        if haptic.isOn {
            UserKeys.StatusSound = true
            let defaults = UserDefaults.standard
            defaults.set(true, forConfigKey: .haptic)
        }else {
            let defaults = UserDefaults.standard
            defaults.set(false, forConfigKey: .haptic)
        }
    }
    
}


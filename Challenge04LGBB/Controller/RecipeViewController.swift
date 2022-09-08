import Foundation
import UIKit
import ARKit
import AVFoundation

var count = 0
var progressBarCount = 0
var eye = false
var sound = false

class RecipeViewController: UIViewController, ARSCNViewDelegate{
    
    @IBOutlet weak var ProgressBarAux: UIStackView!
    var recipes : [Recipe] = []
    var xspace = 5
    var xspaceaux = 5
    var analysis = ""
    var texto = ""
    var escolha : Int = 0
    @IBOutlet weak var botaovoltar: UIButton!
    
    @IBOutlet weak var BotaoTerminarReceita: UIButton!
    
    @IBOutlet weak var botaoir: UIButton!
    
    @IBOutlet weak var progressBar: UIStackView!
    @IBOutlet weak var labelIntrucao: UILabel!
    @IBOutlet weak var imagemIntrucao: UIImageView!
    @IBOutlet weak var labelTurno: UILabel!
    @IBOutlet weak var labelImagem: UILabel!
    @IBOutlet weak var viewTurno: UIView!
    @IBOutlet weak var labelNomeDaReceita: UILabel!
    
    @IBOutlet weak var labelEtapa: UILabel!
    @IBOutlet weak var viewEtapa: UIView!
    
    
    @IBOutlet weak var CorDoFundoDaTela: UIView!
    
    @IBOutlet weak var LampImage: UIImageView!
    @IBOutlet weak var LabelDica: UILabel!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var player : AVAudioPlayer?
    
            override func viewWillAppear(_ animated: Bool) {
                super.viewWillAppear(animated)
                for i in 1...9{
                    let view = UIView(frame: CGRect(x: xspaceaux, y: Int(ProgressBarAux.frame.height)/2, width: 20, height: 20))
                    view.backgroundColor = UIColor.systemGray
                    view.layer.cornerRadius = 10
                    view.layer.zPosition = 0
                    progressBar.addSubview(view)
                    xspaceaux += 22
                }
//                let configuration = ARFaceTrackingConfiguration()
//                sceneView.session.run(configuration)
//                sceneView.preferredFramesPerSecond = 10
//                sceneView.isHidden = true

                let defaults = UserDefaults.standard
//                eye = defaults.bool(forKey: "Touch")
                sound = defaults.bool(forKey: "Sound")
            }
    // MARK: - ARSCNViewDelegate
    
//    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
//        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
//        let node = SCNNode(geometry: faceMesh)
//        node.geometry?.firstMaterial?.fillMode = .lines
//        return node
//    }
    
//    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
//        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
//            faceGeometry.update(from: faceAnchor.geometry)
//            expression(anchor: faceAnchor)
//
//            DispatchQueue.main.async {
//                if eye == true {
//                    self.texto = self.analysis
//                }
//
//                if (self.texto == "You are blinking right." && count < self.recipes[escolha].numeroIntrucoes - 1){
//                    if count < 9 {
//                        count += 1
//                    }
//                    self.play(tiposom: "passar")
//                    self.viewDidLoad()
//                    print(count)
//                }
//                if(self.texto == "You are blinking left." && count != 0){
//                    self.play(tiposom: "voltar")
//                    count -= 1
//                    self.viewDidLoad()
//                    print(count)
//                }
//                else{
//                    print("nao esta piscando")
//                }
//
//            }
//        }
//    }
//
//    func expression(anchor: ARFaceAnchor) {
//        let eyeblinkright = anchor.blendShapes[.eyeBlinkRight]
//        let eyeblinkleft = anchor.blendShapes[.eyeBlinkLeft]
//        self.analysis = ""
//
//        if eyeblinkright?.decimalValue ?? 0.0 > 0.7 {
//            self.analysis += "You are blinking left."
//        }
//        if eyeblinkleft?.decimalValue ?? 0.0 > 0.7 {
//            self.analysis += "You are blinking right."
//        }
//    }
    
    override func viewDidLoad() {
        
        recipes = getRecipes()
        print("a escolha e \(escolha)")
        updateData()
        xspace = 5
        for i in 1...recipes[escolha].auxiliarInstrucoesPorEtapas[count]{
        let view = UIView(frame: CGRect(x: xspace, y: Int(progressBar.frame.height)/2, width: 20, height: 20))
            view.backgroundColor = UIColor(named: "Mix_DarkMagenta")
        view.layer.cornerRadius = 10
        view.layer.zPosition = 1
        progressBar.addSubview(view)
        xspace += 22
    }
  
//
//
//        sceneView.delegate = self
//        guard ARFaceTrackingConfiguration.isSupported else {
//            fatalError("Face tracking is not supported on this device")
//        }
    }
    
    
    @IBAction func NextStep(_ sender: Any) {
        if count == recipes[escolha].numeroIntrucoes-1{
            count = recipes[escolha].numeroIntrucoes-1
        }
        else{
            count += 1
            progressBarCount += 1
            viewDidLoad()
        }
        
        if sound == true {
            play(tiposom: "passar")
        }
        
    }
    
    @IBAction func LastStep(_ sender: Any) {
        if count == 0{
            count = 0
        }
        else{
            count -= 1
            progressBarCount += 1
            viewDidLoad()
        }
        
        if sound == true {
            play(tiposom: "voltar")
        }
        
    }
    
    func updateData(){
        botaoir.backgroundColor = recipes[escolha].CorDaTela[count]
        botaovoltar.backgroundColor = recipes[escolha].CorDaTela[count]
        viewTurno.backgroundColor = recipes[escolha].CorDoFundoDatela[count]
        labelNomeDaReceita.text = "\(recipes[escolha].tituloReceita)"
        viewEtapa.backgroundColor = recipes[escolha].CorDasEtapas[count]
        labelEtapa.text = "\(recipes[escolha].Etapa[count])"
        CorDoFundoDaTela.backgroundColor = recipes[escolha].CorDoFundoDatela[count]
        labelTurno.text = "\(recipes[escolha].pessoaTurno[count])"
        labelIntrucao.text = "\(recipes[escolha].descricaoReceita[count])"
        LabelDica.text = "\(recipes[escolha].dicas[count])"
        imagemIntrucao.image = recipes[escolha].imagemIntrucao[count]
        
        if count == recipes[escolha].numeroIntrucoes-1{
            BotaoTerminarReceita.isHidden = false
        }
        else{
            BotaoTerminarReceita.isHidden = true
        }
        if count == 0 {
            botaovoltar.isHidden = true
        }
        else{botaovoltar.isHidden = false}
        
        if count == recipes[escolha].numeroIntrucoes - 1 {
            botaoir.isHidden = true
        }
        else {botaoir.isHidden = false}
        
        
        if recipes[escolha].pessoaTurno[count] == "Mix"{
            labelImagem.text = "Vocês podem fazer juntos essa etapa!!!"
            LampImage.image = UIImage(named: "Dica - Magenta")
            
        }
        if recipes[escolha].pessoaTurno[count] == "Adulto"{
            labelImagem.text = "Siga as Instruções:"
            LampImage.image = UIImage(named: "Dica - Blue")
        }
        if recipes[escolha].pessoaTurno[count] == "Criança"{
            labelImagem.text = "Siga as Instruções:"
            LampImage.image = UIImage(named: "Dica - ORANGE")
        }
        if recipes[escolha].dicas[count] == "" {
            LampImage.isHidden = true
        }
        else {LampImage.isHidden = false}
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Back" {
            let secondVC = segue.destination as! ChosenRecipeViewController
            secondVC.escolha = escolha
            let transition = CATransition()
            transition.duration = 0.15
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromLeft
            guard let window = view.window else { return }
            window.layer.add(transition, forKey: kCATransition)
            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve
        }
        if segue.identifier == "ForgotRecipe"{
            let secondVC = segue.destination as!ForgotRecipeViewController
            secondVC.escolha = escolha
        }
        if segue.identifier == "End" {
            let secondVC = segue.destination as! EndRecipeViewController
            secondVC.escolha = escolha
        }
    }
    
    @IBAction func playSound(_ sender: Any) {
        if sound == true {
            play(tiposom: "fim-receita")
        }
    }
    
    func play(tiposom : String) {
        
        let urlString = Bundle.main.path(forResource: tiposom, ofType: "mp3")
        
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

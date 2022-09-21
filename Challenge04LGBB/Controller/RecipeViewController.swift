import Foundation
import UIKit
import ARKit
import AVFoundation

var eye = false
var sound = false
var haptic = false

class RecipeViewController: UIViewController, ARSCNViewDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var botaovoltar: UIButton!
    @IBOutlet weak var BotaoTerminarReceita: UIButton!
    @IBOutlet weak var botaoir: UIButton!
    @IBOutlet weak var labelIntrucao: UILabel!
    @IBOutlet weak var imagemIntrucao: UIImageView!
    @IBOutlet weak var labelTurno: UILabel!
    @IBOutlet weak var labelImagem: UILabel!
    @IBOutlet weak var viewTurno: UIView!
    @IBOutlet weak var labelEtapa: UILabel!
    @IBOutlet weak var viewEtapa: UIView!
    @IBOutlet weak var CorDoFundoDaTela: UIView!
    @IBOutlet weak var LampImage: UIImageView!
    @IBOutlet weak var LabelDica: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var TituloDaReceita: UINavigationItem!
    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet weak var botaoFoto: UIButton!
    var imagePicker: UIImagePickerController!

    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    var player : AVAudioPlayer?
    var recipes : [Recipe] = []
    var xspace = 5
    var xspaceaux = 5
    var analysis = ""
    var texto = ""
    var escolha : Int = 0
    var count : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        AppDelegate.AppUtility.lockOrientation(.portrait)
        
        let defaults = UserDefaults.standard
        eye = defaults.bool(forKey: "Touch")
        sound = defaults.bool(forKey: "Sound")
        haptic = defaults.bool(forKey: "Haptic")
        
        let configuration = ARFaceTrackingConfiguration()
        
        if eye == true {
            sceneView.session.run(configuration)
            sceneView.preferredFramesPerSecond = 5
            sceneView.isHidden = true
        }
        
    }
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let faceMesh = ARSCNFaceGeometry(device: sceneView.device!)
        let node = SCNNode(geometry: faceMesh)
        node.geometry?.firstMaterial?.fillMode = .lines
        return node
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        if let faceAnchor = anchor as? ARFaceAnchor, let faceGeometry = node.geometry as? ARSCNFaceGeometry {
            faceGeometry.update(from: faceAnchor.geometry)
            expression(anchor: faceAnchor)
            
            DispatchQueue.main.async {
                if eye == true {
                    self.texto = self.analysis
                }
                
                if (self.texto == "You are blinking right." && self.count < self.recipes[self.escolha].numeroIntrucoes - 1){
                    if self.count < 9 {
                        self.count += 1
                    }
                    self.play(tiposom: "passar")
                    self.viewDidLoad()
                    print(self.count)
                }
                if(self.texto == "You are blinking left." && self.count != 0){
                    self.play(tiposom: "voltar")
                    self.count -= 1
                    self.viewDidLoad()
                    print(self.count)
                }
                
                
            }
        }
    }
    
    func expression(anchor: ARFaceAnchor) {
        let eyeblinkright = anchor.blendShapes[.eyeBlinkRight]
        let eyeblinkleft = anchor.blendShapes[.eyeBlinkLeft]
        let mouthLeft = anchor.blendShapes[.mouthRight]
        let mouthRight = anchor.blendShapes[.mouthLeft]
        self.analysis = ""
        
        if eyeblinkright?.decimalValue ?? 0.0 > 0.7 ||  mouthLeft?.decimalValue ?? 0.0 > 0.7{
            self.analysis += "You are blinking left."
        }
        if eyeblinkleft?.decimalValue ?? 0.0 > 0.7 || mouthRight?.decimalValue ?? 0.0 > 0.7{
            self.analysis += "You are blinking right."
        }
    }
    
    override func viewDidLoad() {
        BackBarButton()
        recipes = getRecipes()
        
        updateData()
        
        BotaoTerminarReceita.layer.cornerRadius = 20
        sceneView.delegate = self
        
    }
    
    
    
    
    @IBAction func NextStep(_ sender: Any) {
        if count == recipes[escolha].numeroIntrucoes-1{
            count = recipes[escolha].numeroIntrucoes-1
        }
        else{
            
            count += 1
            viewDidLoad()
        }
        
        play(tiposom: "passar")
        if haptic == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    @IBAction func LastStep(_ sender: Any) {
        if count == 0{
            count = 0
        }
        else{
            count -= 1
            viewDidLoad()
        }
        
        
        play(tiposom: "voltar")
        if haptic == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
        
    }
    
    func BackBarButton(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.isAccessibilityElement = true
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Botão para mostrar a lista de ingredientes e etapas da receita"
    }
    
    func updateData(){
        
        progressBar.progress = recipes[escolha].progressBar[count]
        progressBar.progressTintColor = recipes[escolha].CorDaTela[count]
        TituloDaReceita.title = "\(recipes[escolha].tituloReceita)".localize()
        botaoir.backgroundColor = recipes[escolha].CorDaTela[count]
        botaovoltar.backgroundColor = recipes[escolha].CorDaTela[count]
        viewTurno.backgroundColor = recipes[escolha].CorDoFundoDatela[count]
        viewEtapa.backgroundColor = recipes[escolha].CorDasEtapas[count]
        labelEtapa.text = "\(recipes[escolha].Etapa[count])".localize()
        CorDoFundoDaTela.backgroundColor = recipes[escolha].CorDoFundoDatela[count]
        labelTurno.text = "\(recipes[escolha].pessoaTurno[count])".localize()
        labelIntrucao.text = "\(recipes[escolha].descricaoReceita[count])".localize()
        LabelDica.text = "\(recipes[escolha].dicas[count])".localize()
        imagemIntrucao.image = recipes[escolha].imagemIntrucao[count]
        imagemIntrucao.isAccessibilityElement = true
        imagemIntrucao.accessibilityLabel = "Imagem que resume a intrução da etapa atual da receita"
        LampImage.isAccessibilityElement = true
        LampImage.accessibilityLabel = "Icone de dicas com texto ao lado direito"
        botaoFoto.backgroundColor = recipes[escolha].CorDaTela[count]
        botaoFoto.layer.cornerRadius = 0.5 * botaoFoto.bounds.size.width
        botaoFoto.clipsToBounds = true
        botaoFoto.isAccessibilityElement = true
        botaoFoto.accessibilityLabel = "Botão para tirar foto"
        
        if count == recipes[escolha].numeroIntrucoes-1{
            BotaoTerminarReceita.isHidden = false
            BotaoTerminarReceita.layer.cornerRadius = 550
            BotaoTerminarReceita.backgroundColor = recipes[escolha].CorDaTela[count]
            BotaoTerminarReceita.isAccessibilityElement = true
            BotaoTerminarReceita.accessibilityLabel = "Botão para terminar a receita, É hora de comer!"
        }
        else{
            BotaoTerminarReceita.isHidden = true
        }
        
        if count == 0 {
            botaovoltar.isHidden = true
            
        }else{
            botaovoltar.isHidden = false
            botaovoltar.isAccessibilityElement = true
            botaovoltar.accessibilityLabel = "Botão para voltar uma etapa da receita"
        }
        
        if count == recipes[escolha].numeroIntrucoes - 1 {
            botaoir.isHidden = true
        }else {
            botaoir.isHidden = false
            botaoir.isAccessibilityElement = true
            botaoir.accessibilityLabel = "Botão para avançar uma etapa da receita"
        }
        
        if recipes[escolha].pessoaTurno[count] == "Mix"{
            labelImagem.text = "Vocês podem fazer essa etapa juntos!!!".localize()
            LampImage.image = UIImage(named: "Dica - Magenta")
        }
        
        if recipes[escolha].pessoaTurno[count] == "Adulto"{
            labelImagem.text = "Siga as instruções abaixo:".localize()
            LampImage.image = UIImage(named: "Dica - Blue")
        }
        
        if recipes[escolha].pessoaTurno[count] == "Criança"{
            labelImagem.text = "Siga as instruções abaixo:".localize()
            LampImage.image = UIImage(named: "Dica - ORANGE")
        }
        
        if recipes[escolha].dicas[count] == "" {
            LampImage.isHidden = true
        }else {
            LampImage.isHidden = false
            
        }
        
    }
    
    func navigation(destino:String){
        if destino == "ForgotRecipe"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "ForgetRecipe", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ForgetRecipe") as! ForgotRecipeViewController
            
            let escolha = escolha
            newViewController.escolha = escolha
            
            self.present(newViewController, animated:true, completion:nil)
            
        }
        
        if destino == "End"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "EndRecipe", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "EndRecipe") as! EndRecipeViewController
            
            let escolha = escolha
            newViewController.escolha = escolha
            navigationController?.modalPresentationStyle = .formSheet
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    @IBAction func goright(_ sender: Any) {
        
        if count == recipes[escolha].numeroIntrucoes-1{
            count = recipes[escolha].numeroIntrucoes-1
            
        }
        else{
            count += 1
            play(tiposom: "passar")
            if haptic == true {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            viewDidLoad()
        }
        
    }
    
    @IBAction func goleft(_ sender: Any) {
        if count == 0{
            count = 0
        }
        else{
            count -= 1
            play(tiposom: "voltar")
            if haptic == true {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            viewDidLoad()
        }
        
    }
    
    @IBAction func ForgetRecipeButton(_ sender: Any) {
        navigation(destino: "ForgotRecipe")
        
    }
    
    @IBAction func playSound(_ sender: Any) {
        navigation(destino: "End")
        if haptic == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
        }
        play(tiposom: "fim-receita")
        
    }
    
    func play(tiposom : String) {
        if sound == true{
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
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }

    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }

    //MARK: - Saving Image here
    func save(_ sender: AnyObject) {
        guard let selectedImage = imageTake.image else {
            print("Image not found!")
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            showAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            showAlertWith(title: "Saved!", message: "Your image has been saved to your photos.")
        }
    }

    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}

extension RecipeViewController: UIImagePickerControllerDelegate{

   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
       imagePicker.dismiss(animated: true, completion: nil)
       guard let selectedImage = info[.originalImage] as? UIImage else {
           print("Image not found!")
           return
       }
       imageTake.image = selectedImage
       save(self)
   }
}


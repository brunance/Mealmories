import Foundation
import UIKit
import ARKit
import AVFoundation
import PhotosUI
import SwiftUI

var eye = false
var sound = false
var haptic = false

class RecipeViewController: UIViewController, ARSCNViewDelegate,UINavigationControllerDelegate {
    //Progess Bar
    @IBOutlet weak var progressBar: UIProgressView!
    //Botoes da tela
    @IBOutlet weak var botaoVoltar: UIButton!
    @IBOutlet weak var botaoTerminarReceita: UIButton!
    @IBOutlet weak var botaoIr: UIButton!
    //Informacoes da tela
    @IBOutlet weak var labelIntrucao: UILabel!
    @IBOutlet weak var imagemIntrucao: UIImageView!
    @IBOutlet weak var labelTurno: UILabel!
    @IBOutlet weak var labelImagem: UILabel!
    @IBOutlet weak var viewTurno: UIView!
    @IBOutlet weak var imagemTurno: UIImageView!
    @IBOutlet weak var corDoFundoDaTela: UIView!
    @IBOutlet weak var lampImage: UIImageView!
    @IBOutlet weak var labelDica: UILabel!
    //SceneView
    @IBOutlet weak var sceneView: ARSCNView!
    //Nome da receita na Navigation Bar
    @IBOutlet weak var tituloDaReceita: UINavigationItem!
    //Funcoes de tirar foto
    @IBOutlet weak var imageTake: UIImageView!
    @IBOutlet weak var botaoFoto: UIButton!
    var imagePicker: UIImagePickerController!
    
    enum imageSource {
        case photoLibrary
        case camera
    }
    
    var player : AVAudioPlayer?
    var recipes : [Recipe] = []
    var xspace = 5
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
        setupNavigationBackButton()
        recipes = getRecipes()
        
        updateData()
        
        botaoTerminarReceita.layer.cornerRadius = 20
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
    
    func setupNavigationBackButton(){
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem?.isAccessibilityElement = true
        self.navigationItem.rightBarButtonItem?.accessibilityLabel = "Botão para mostrar a lista de ingredientes e etapas da receita"
    }
    
    func updateData(){
        progressBar.progress = recipes[escolha].progressBar[count]
        tituloDaReceita.title = "\(recipes[escolha].tituloReceita)".localize()
        
        if recipes[escolha].pessoaTurno[count] == "Mix"{
            progressBar.progressTintColor = UIColor.magentaTela
            botaoIr.backgroundColor = UIColor.magentaTela
            botaoVoltar.backgroundColor = UIColor.magentaTela
            botaoTerminarReceita.backgroundColor = UIColor.magentaTela
            viewTurno.backgroundColor = UIColor.magentaFundo
            corDoFundoDaTela.backgroundColor = UIColor.magentaFundo
            botaoFoto.backgroundColor = UIColor.magentaTela
            labelImagem.text = "Vocês podem fazer essa etapa juntos!!!".localize()
            lampImage.image = UIImage(named: "Dica - Magenta")
            imagemTurno.image = UIImage(named: "turno.mix")
        }
        
        if recipes[escolha].pessoaTurno[count] == "Adulto"{
            progressBar.progressTintColor = UIColor.blueTela
            botaoIr.backgroundColor = UIColor.blueTela
            botaoVoltar.backgroundColor = UIColor.blueTela
            botaoTerminarReceita.backgroundColor = UIColor.blueTela
            viewTurno.backgroundColor = UIColor.blueFundo
            corDoFundoDaTela.backgroundColor = UIColor.blueFundo
            botaoFoto.backgroundColor = UIColor.blueTela
            labelImagem.text = "Siga as instruções abaixo:".localize()
            lampImage.image = UIImage(named: "Dica - Blue")
            imagemTurno.image = UIImage(named: "turno.adulto")
        }
        
        if recipes[escolha].pessoaTurno[count] == "Criança"{
            progressBar.progressTintColor = UIColor.orangeTela
            botaoIr.backgroundColor = UIColor.orangeTela
            botaoVoltar.backgroundColor = UIColor.orangeTela
            botaoTerminarReceita.backgroundColor = UIColor.orangeTela
            viewTurno.backgroundColor = UIColor.orangeFundo
            corDoFundoDaTela.backgroundColor = UIColor.orangeFundo
            botaoFoto.backgroundColor = UIColor.orangeTela
            labelImagem.text = "Siga as instruções abaixo:".localize()
            lampImage.image = UIImage(named: "Dica - ORANGE")
            imagemTurno.image = UIImage(named: "turno.child")
        }
        
        labelTurno.text = "\(recipes[escolha].pessoaTurno[count])".localize()
        labelIntrucao.text = "\(recipes[escolha].descricaoReceita[count])".localize()
        labelDica.text = "\(recipes[escolha].dicas[count])".localize()
        imagemIntrucao.image = recipes[escolha].imagemIntrucao[count]
        
        imagemIntrucao.isAccessibilityElement = true
        imagemIntrucao.accessibilityLabel = "Imagem que resume a intrução da etapa atual da receita"
        lampImage.isAccessibilityElement = true
        lampImage.accessibilityLabel = "Icone de dicas com texto ao lado direito"
        
        botaoFoto.layer.cornerRadius = 0.5 * botaoFoto.bounds.size.width
        botaoFoto.clipsToBounds = true
        botaoFoto.isAccessibilityElement = true
        botaoFoto.accessibilityLabel = "Botão para tirar foto"
        
        if count == recipes[escolha].numeroIntrucoes-1{
            botaoTerminarReceita.isHidden = false
            botaoTerminarReceita.layer.cornerRadius = 550
            botaoTerminarReceita.isAccessibilityElement = true
            botaoTerminarReceita.accessibilityLabel = "Botão para terminar a receita, É hora de comer!"
        }
        else{
            botaoTerminarReceita.isHidden = true
        }
        
        if count == 0 {
            botaoVoltar.isHidden = true
        }else{
            botaoVoltar.isHidden = false
            botaoVoltar.isAccessibilityElement = true
            botaoVoltar.accessibilityLabel = "Botão para voltar uma etapa da receita"
        }
        
        if count == recipes[escolha].numeroIntrucoes - 1 {
            botaoIr.isHidden = true
        }else {
            botaoIr.isHidden = false
            botaoIr.isAccessibilityElement = true
            botaoIr.accessibilityLabel = "Botão para avançar uma etapa da receita"
        }
        
        
        if recipes[escolha].dicas[count] == "" {
            lampImage.isHidden = true
        }else {
            lampImage.isHidden = false
            
        }
        
    }
    
    func navigation(destino:String) {
        
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
        
        if destino == "Timer"{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Timer", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Timer") as! TimerController
            
            
            navigationController?.modalPresentationStyle = .formSheet
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    
    @IBAction func goRight(_ sender: Any) {
        
        if count == recipes[escolha].numeroIntrucoes-1{
            count = recipes[escolha].numeroIntrucoes-1
            
        } else{
            count += 1
            play(tiposom: "passar")
            if haptic == true {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            viewDidLoad()
        }
    }
    
    @IBAction func goLeft(_ sender: Any) {
        if count == 0{
            count = 0
        }else{
            count -= 1
            play(tiposom: "voltar")
            if haptic == true {
                let generator = UINotificationFeedbackGenerator()
                generator.notificationOccurred(.success)
            }
            viewDidLoad()
        }
    }
    
    @IBAction func forgetRecipeButton(_ sender: Any) {
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
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                DispatchQueue.main.async {
                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                        self.selectImageFrom(.photoLibrary)
                        return
                    }
                    self.selectImageFrom(.camera)
                    if haptic == true {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.warning)
                    }
                }
            }else {
                DispatchQueue.main.async { [unowned self] in
                    let alertController = UIAlertController(title: "Permissão Necessária".localize(), message: "Para salvar as fotos, é necessário habilitar a permissão nos Ajustes".localize(), preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ajustes".localize(), style: .cancel) { _ in
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:] , completionHandler: {
                                _ in
                            })
                        }
                    })
                    alertController.addAction(UIAlertAction(title: "Cancelar".localize(), style: .default))
                    
                    
                    present(alertController, animated: true)
                }
            }
        }
        
    }
    
    func selectImageFrom(_ source: imageSource){
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
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { response in
            if response == PHAuthorizationStatus.denied{
                DispatchQueue.main.async { [unowned self] in
                    let alertController = UIAlertController(title: "Permissão Necessária".localize(), message: "Para salvar as fotos, é necessário habilitar a permissão nos Ajustes".localize(), preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Ajustes".localize(), style: .cancel) { _ in
                        if let url = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(url, options: [:] , completionHandler: {
                                _ in
                            })
                        }
                    })
                    alertController.addAction(UIAlertAction(title: "Cancelar".localize(), style: .default))
                    
                    
                    present(alertController, animated: true)
                }
            }
        }
    }
    
    func showAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    
    @IBAction func timerButton(_ sender: Any) {
        navigation(destino: "Timer")
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


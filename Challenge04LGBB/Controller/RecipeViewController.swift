import Foundation
import UIKit
import ARKit

var count = 0
var progressBarCount = 0
var eye = false

class RecipeViewController: UIViewController, ARSCNViewDelegate{
    
    @IBOutlet weak var ProgressBarAux: UIStackView!
    var recipes : [Recipe] = []
    var xspace = 5
    var xspaceaux = 5
    var analysis = ""
    var texto = ""
    
    @IBOutlet weak var botaovoltar: UIButton!
    
    
    @IBOutlet weak var fundoDalampada: UIView!
    @IBOutlet weak var botaoir: UIButton!
    
    @IBOutlet weak var progressBar: UIStackView!
    @IBOutlet weak var labelIntrucao: UILabel!
    @IBOutlet weak var imagemIntrucao: UIImageView!
    @IBOutlet weak var labelTurno: UILabel!
    @IBOutlet weak var labelImagem: UILabel!
    @IBOutlet weak var viewTurno: UIView!
    @IBOutlet weak var labelContagemTurno: UILabel!
    
    @IBOutlet weak var statusbar: UIView!
    
    @IBOutlet weak var CorDoFundoDaTela: UIView!
    
    @IBOutlet weak var LampImage: UIImageView!
    @IBOutlet weak var LabelDica: UILabel!
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARFaceTrackingConfiguration()
        sceneView.session.run(configuration)
        sceneView.preferredFramesPerSecond = 10
        sceneView.isHidden = true
        
        let defaults = UserDefaults.standard
        eye = defaults.bool(forKey: "Touch")
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
                
                if (self.texto == "You are blinking right." && count < self.recipes[0].numeroIntrucoes - 1){
                    if count < 9 {
                        count += 1
                    }
                    self.NextStep()
                    print(count)
                }
                if(self.texto == "You are blinking left." && count != 0){
                    count -= 1
                    self.LastStep()
                    print(count)
                }
                else{
                    print("nao esta piscando")
                }
                
            }
        }
    }
    
    func expression(anchor: ARFaceAnchor) {
        let eyeblinkright = anchor.blendShapes[.eyeBlinkRight]
        let eyeblinkleft = anchor.blendShapes[.eyeBlinkLeft]
        self.analysis = ""
        
        if eyeblinkright?.decimalValue ?? 0.0 > 0.7 {
            self.analysis += "You are blinking left."
        }
        if eyeblinkleft?.decimalValue ?? 0.0 > 0.7 {
            self.analysis += "You are blinking right."
        }
    }
    
    override func viewDidLoad() {
        
        recipes = [
            Recipe(tituloReceita: "Pão de Queijo", numeroIntrucoes: 9, pessoaTurno: ["Adulto", "Criança", "Mix", "Adulto", "Mix", "Criança", "Mix", "Adulto", "Adulto"], descricaoReceita: ["Em uma vasilha, junte os ingredientes secos: polvilho doce, e parmesão", "Misture bem com uma colher ou com a mão!", "Adicione o creme de leite, aos poucos, misturando com as mãos até formar uma massa homogênea e firme.","Retire porções pequenas da massa", "Modele do formato que quiser, bolinhas, dadinhos, seja criativo!", "Unte uma fôrma com manteiga e trigo, papel manteiga ou spray de untar ", "Coloque uma ao lado da outra na fôrma grande untada", "Leve ao forno alto, preaquecido a 180°C , por 15 minutos ou até dourar.", "Retire e sirva em seguida."], numeroEtapas: 3,
                   imagemIntrucao:
                    [UIImage(named: "secos.1")!
                     ,UIImage(named: "mistura.1")!
                     ,UIImage(named: "liquidoemistura.1")!
                     ,UIImage(named: "porções")!
                     ,UIImage(named: "modelagem.1")!
                     ,UIImage(named: "untarforma.1")!
                     ,UIImage(named: "Organizarnaforma.1")!
                     ,UIImage(named: "forno.1")!,
                     UIImage(named: "paodequeijo.1")!]
                   ,CorDaTela: [UIColor(named: "Adulto_Blue")!,UIColor(named: "Child_Orange")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Adulto_Blue")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Child_Orange")!,UIColor(named: "Mix_Magenta")!,UIColor(named: "Adulto_Blue")!,UIColor(named: "Adulto_Blue")!],dicas: ["Qualquer dos dois tipos de polvilhos são bem-vindos, variando de acordo com o gosto de quem manuseia a receita","","É necessário que o creme de leite seja adicionado aos poucos, para não perder o ponto da massa.","","É necessário que o creme de leite seja adicionado aos poucos, para não perder o ponto da massa.","Pode haver ajuda do adulto na orientação, mas é interessante que a criança faça sozinha.","Deixe sempre um pequeno espaço entre as massas , pode facilitar na hora de retirar os pães.","",""],CorDoFundoDatela: [UIColor(named: "LabelBlue")!,UIColor(named: "LabelOrange")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelBlue")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelOrange")!,UIColor(named: "LabelMagenta")!,UIColor(named: "LabelBlue")!,UIColor(named: "LabelBlue")!],Etapas: [1,1,1,2,2,3,3,3,3],InstruçõesPorEtapa: [1,2,3,1,2,1,2,3,4],auxiliarInstrucoesPorEtapa: [3,3,3,2,2,4,4,4,4])]
        
        botaoir.backgroundColor = recipes[0].CorDaTela[count]
        botaovoltar.backgroundColor = recipes[0].CorDaTela[count]
        viewTurno.backgroundColor = recipes[0].CorDoFundoDatela[count]
        labelContagemTurno.text = "Etapa \(recipes[0].Etapas[count]) de \(recipes[0].numeroEtapas)"
        CorDoFundoDaTela.backgroundColor = recipes[0].CorDoFundoDatela[count]
        labelTurno.text = "\(recipes[0].pessoaTurno[count])"
        labelIntrucao.text = "\(recipes[0].descricaoReceita[count])"
        LabelDica.text = "\(recipes[0].dicas[count])"
        statusbar.backgroundColor = recipes[0].CorDaTela[count]
        imagemIntrucao.image = recipes[0].imagemIntrucao[count]
        if recipes[0].dicas[count] == ""{
            LampImage.isHidden = true
            fundoDalampada.isHidden = true
        }
        fundoDalampada.backgroundColor = recipes[0].CorDaTela[count]
        if recipes[0].pessoaTurno[count] == "Mix"{
            labelImagem.text = "Vocês podem fazer juntos essa etapa!!!"
        }
        else{labelImagem.text = "Siga as instruções:"}
        
        for i in 1...recipes[0].InstruçõesPorEtapa[count]{
            let view = UIView(frame: CGRect(x: xspace, y: Int(progressBar.frame.height)/2, width: 20, height: 20))
            view.backgroundColor = recipes[0].CorDaTela[count]
            view.layer.cornerRadius = 10
            view.layer.zPosition = 1
            progressBar.addSubview(view)
            xspace += 22
            
        }
        for i in 1...recipes[0].auxiliarInstrucoesPorEtapa[count]{
            let view = UIView(frame: CGRect(x: xspaceaux, y: Int(ProgressBarAux.frame.height)/2, width: 20, height: 20))
            view.backgroundColor = UIColor.systemGray
            view.layer.cornerRadius = 10
            view.layer.zPosition = 0
            progressBar.addSubview(view)
            xspaceaux += 22

        }

        
        
        sceneView.delegate = self
        guard ARFaceTrackingConfiguration.isSupported else {
            fatalError("Face tracking is not supported on this device")
        }
    }
    
    
    @IBAction func NextStep(_ sender: Any) {
        if count == recipes[0].numeroIntrucoes-1{
            count = recipes[0].numeroIntrucoes-1
        }
        else{
            count += 1
            progressBarCount += 1
            LastStep()
        }
        
        
        
    }
    @IBAction func LastStep(_ sender: Any) {
        if count == 0{
            count = 0
        }
        else{
            count -= 1
            progressBarCount += 1
            NextStep()
        }
        
    }
    
    
    func NextStep(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
        
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
    func LastStep(){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! RecipeViewController
        
        
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        guard let window = view.window else { return }
        window.layer.add(transition, forKey: kCATransition)
        newViewController.modalPresentationStyle = .fullScreen
        self.present(newViewController, animated: false, completion: nil)
    }
}

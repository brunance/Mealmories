//
//  EndRecipe.swift
//  Challenge04LGBB
//
//  Created by Luciano Uchoa on 26/08/22.
//

import Foundation
import UIKit
import AVFoundation

class EndRecipeViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var ImageMedalha: UIImageView!
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var labelDesbloqueio: UILabel!
    @IBOutlet weak var CameraButton: UIButton!
    @IBOutlet weak var imageTake: UIImageView!
    var imagePicker: UIImagePickerController!
    var escolha = 0
    
    let confetti = classyConfetti()
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        imageTake.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        confetti.emit(in: view, with: .fromCenter)
        
        AppDelegate.AppUtility.lockOrientation(.allButUpsideDown)
    }
    func setupLabel(){
        let receitas = getRecipes()
        ImageMedalha.image = receitas[escolha].medalha
        labelDesbloqueio.text = receitas[escolha].tituloReceita.localize()
        ImageMedalha.isAccessibilityElement = true
        ImageMedalha.accessibilityLabel = "Imagem da medalha ganha por terminar a receita!"
        CameraButton.layer.cornerRadius = 10
    }
    
    @IBAction func BackTorecipesScreen(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ListRecipesScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "recipesScreen") as! ListRecipesViewController
        
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    
    //MARK: - Take image
    @IBAction func takePhoto(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            selectImageFrom(.photoLibrary)
            return
        }
        selectImageFrom(.camera)
        if haptic == true {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
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
        imageTake.isHidden = false
        CameraButton.isHidden = true
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

extension EndRecipeViewController: UIImagePickerControllerDelegate{

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



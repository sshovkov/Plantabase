//
//  CreateProfileViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit
import CoreData

class CreateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var plantField: UITextField!
    @IBOutlet weak var uploadProfilePictureButton: UIButton!
    
    
    
    var m:Model?
    var returnTemp = "Returned Home from Create View"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadProfilePictureButton.layer.cornerRadius = 25
    }
    
    @IBAction func createProfile(_ sender: UIButton) {
        
        if (nameField.text == "" || plantField.text == "") {
            let alert2 = UIAlertController(title: "One of the fields is invalid. Please try again.", message: nil, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
            alert2.addAction(cancelAction)
            self.present(alert2, animated: true, completion: nil)
        }
        else {
            // create alert controller for diplaying option to select image
            let alert = UIAlertController(title: "Set a Profile Picture", message: nil, preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
            let photoPicker = UIImagePickerController()
            photoPicker.delegate = self
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { (action) in
                photoPicker.sourceType = .photoLibrary
                self.present (photoPicker, animated: true, completion: nil)
            }
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { (action) in
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    photoPicker.sourceType = .camera
                    self.present (photoPicker, animated: true, completion: nil)
                } else {
                    let alert3 = UIAlertController(title: "Camera is not available right now.", message: nil, preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
                    alert3.addAction(cancelAction)
                    self.present(alert3, animated: true, completion: nil)
                    print("Camera is not available")
                }
            }
            
            alert.addAction(photoLibraryAction)
            alert.addAction(cameraAction)
            alert.addAction(cancelAction)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        var selectedImage: UIImage?
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        selectedImage = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage
        let imageData = selectedImage!.pngData()
        
        m?.SaveContext(userName: nameField.text!, userPlant: plantField.text!, UserPic: imageData!)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
        return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
    }

    // Helper function inserted by Swift 4.2 migrator.
    fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
        return input.rawValue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

}

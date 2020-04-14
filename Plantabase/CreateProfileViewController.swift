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
        m?.SaveContext(userName: nameField.text!, userPlant: plantField.text!)
    }
    

}

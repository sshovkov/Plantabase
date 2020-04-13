//
//  CreateProfileViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var plantField: UITextField!
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var userModel:UserEntity?
    
    
    // Array to store User entities from the coredata
    var fetchResults = [UserEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userModel = UserEntity(context: managedObjectContext)
    
    }
    
    @IBAction func uploadProfilePicButton(_ sender: UIButton) {
        userModel?.SaveContext(name: nameField.text!, favePlant: plantField.text!)
    }
    
    
    

}

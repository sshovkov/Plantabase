//
//  ViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit
import CoreData

// view controller of launch page

class ViewController: UIViewController {

    @IBOutlet weak var findNurseryButton: UIButton!
    @IBOutlet weak var goToProfileButton: UIButton!
    @IBOutlet weak var createProfileButton: UIButton!
    var m:Model?
    var m1:ModelShop?
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        m = Model(context: managedObjectContext)
        m1 = ModelShop(context: managedObjectContext)
        
        findNurseryButton.layer.cornerRadius = 25
        goToProfileButton.layer.cornerRadius = 25
        createProfileButton.layer.cornerRadius = 25
        
        print("Count is: \(m?.fetchRecords().count ?? -1)")
        print("Name is: \(m?.fetchRecords().last?.name ?? "userName")")
        print("Fave Plant is: \(m?.fetchRecords().last?.favePlant ?? "userPlant")")
        print("Saved shops: \(m1?.fetchRecords().count ?? -1)")
        
        
        if (m?.fetchRecords().count == 0) {
            createProfileButton.isHidden = false
            goToProfileButton.isHidden = true
        } else {
            createProfileButton.isHidden = true
            goToProfileButton.isHidden = false
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    // Segue either toCreate or toProfile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "toCreate") {
            let destination = segue.destination as! CreateProfileViewController
            destination.m = self.m
        }
        
        if (segue.identifier == "toProfile") {
            let destination = segue.destination as! ProfileViewController
            let lastEntity = m?.fetchRecords().last
            destination.userItem = lastEntity
        }
    }
    
    @IBAction func returnedFromcreate(segue:UIStoryboardSegue) {
        
        if let sourceViewController = segue.source as? CreateProfileViewController {
            let dataReceived = sourceViewController.returnTemp
            print(dataReceived)
        }
        
        if (m?.fetchRecords().count == 0) {
            createProfileButton.isHidden = false
            goToProfileButton.isHidden = true
        } else {
            createProfileButton.isHidden = true
            goToProfileButton.isHidden = false
        }
    }


}


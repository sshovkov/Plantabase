//
//  ViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

// view controller of launch page

class ViewController: UIViewController {

    @IBOutlet weak var findNurseryButton: UIButton!
    @IBOutlet weak var goToProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findNurseryButton.layer.cornerRadius = 25
        goToProfileButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }


}


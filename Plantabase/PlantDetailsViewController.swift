//
//  PlantDetailsViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 4/19/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class PlantDetailsViewController: UIViewController {
    
    var selectedPlantName:String?
    var selectedPlantPic:UIImage?

    @IBOutlet weak var plantPic: UIImageView!
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var background: UILabel!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var waterLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    // Model
    var plantInfoAccess:PlantInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        background.layer.cornerRadius =  40
        
        self.plantPic.image = selectedPlantPic
        self.plantPic.layer.masksToBounds = true
        self.plantPic.contentMode = UIView.ContentMode.scaleAspectFill
        self.plantPic.layer.cornerRadius = plantPic.bounds.width/2
        self.plantPic.clipsToBounds = true
        
        plantInfoAccess = PlantInfo.init(name: selectedPlantName!)
        
        plantName.text = selectedPlantName
        lightLabel.text = plantInfoAccess!.plantCareInfo().0
        waterLabel.text = plantInfoAccess!.plantCareInfo().1
        tipLabel.text = plantInfoAccess!.plantCareInfo().2

        // Do any additional setup after loading the view.
    }


}

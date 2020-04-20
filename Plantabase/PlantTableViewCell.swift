//
//  PlantTableViewCell.swift
//  Plantabase
//
//  Created by Shovkovy on 4/19/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class PlantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var plantName: UILabel!
    
    @IBOutlet weak var plantPic: UIImageView! {
        didSet {
            plantPic.layer.cornerRadius = plantPic.bounds.width/2
            plantPic.clipsToBounds = true
            plantPic.contentMode = UIView.ContentMode.scaleAspectFill
            plantPic.layer.masksToBounds = true
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

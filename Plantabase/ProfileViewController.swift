//
//  ProfileViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userItem:UserEntity?
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favoritePlant: UILabel!
    @IBOutlet weak var shopCountLabel: UILabel!
    @IBOutlet weak var plantCountLabel: UILabel!
    
    var shopCount = 0
    var plantCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = userItem?.name
        favoritePlant.text = userItem?.favePlant
        setImage()
        shopCountLabel.text = String(shopCount)
        plantCountLabel.text = String(plantCount)
        // Do any additional setup after loading the view.
    }
    
    func setImage() {
        let picture2 = UIImage(data: userItem!.picture! as Data)
        profilePic.image = picture2
        self.profilePic.layer.masksToBounds = true
        self.profilePic.contentMode = UIView.ContentMode.scaleAspectFill
        self.profilePic.layer.cornerRadius = profilePic.bounds.width/2
        self.profilePic.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

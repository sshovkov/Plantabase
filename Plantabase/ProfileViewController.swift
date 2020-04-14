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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text = userItem?.name
        favoritePlant.text = userItem?.favePlant
        //setImage()

        // Do any additional setup after loading the view.
    }
    
    func setImage() {
        //self.profile.image = picName
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

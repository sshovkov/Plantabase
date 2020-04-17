//
//  ProfileViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userItem:UserEntity?
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var favoritePlant: UILabel!
    @IBOutlet weak var shopCountLabel: UILabel!
    @IBOutlet weak var plantCountLabel: UILabel!
    @IBOutlet weak var profileTable: UITableView!
    
    var m:ModelShop?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var shopCount = 0
    var plantCount = 0
    var arrayOfShops:Array<ShopListEntity>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        m = ModelShop(context: managedObjectContext)
        
        userName.text = userItem?.name
        favoritePlant.text = userItem?.favePlant
        setImage()
        shopCountLabel.text = String(shopCount)
        plantCountLabel.text = String(plantCount)
        arrayOfShops = m?.fetchRecords()
        profileTable.reloadData()
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
    
    
    // Populate the table view from core data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfShops?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        cell.layer.borderWidth = 1.0
        print("Debugging. ShopName is \(arrayOfShops![indexPath.row].shopName)")
        cell.shopTitle.text = arrayOfShops![indexPath.row].shopName

        return cell

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

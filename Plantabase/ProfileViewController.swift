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
    @IBOutlet weak var profileTable: UITableView!
    @IBOutlet weak var myPlantsBtn: UIButton!
    @IBOutlet weak var nurseriesLabel: UILabel!
    
    var m:ModelShop?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfShops = [ShopListEntity]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let m = ModelShop(context: managedObjectContext)
        myPlantsBtn.layer.cornerRadius = 20
        userName.text = userItem?.name
        favoritePlant.text = userItem?.favePlant
        setImage()
        arrayOfShops = m.fetchRecords()
        if (arrayOfShops.count == 1){
            nurseriesLabel.text = "NURSERY"
        }
        shopCountLabel.text = String(arrayOfShops.count)
        profileTable.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func setImage() {
        let picture2 = UIImage(data: userItem!.picture!)
        profilePic.image = picture2
        self.profilePic.layer.masksToBounds = true
        self.profilePic.contentMode = UIView.ContentMode.scaleAspectFill
        self.profilePic.layer.cornerRadius = profilePic.bounds.width/2
        self.profilePic.clipsToBounds = true
    }
    
    
    // Populate the table view from core data
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfShops.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        cell.layer.borderWidth = 1.0
        cell.textLabel?.text = arrayOfShops[indexPath.row].shopName

        return cell

    }
    
    // Delete table entry (swipe right to left)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    private func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            managedObjectContext.delete(arrayOfShops[indexPath.row])
            arrayOfShops.remove(at: indexPath.row)
            
            do {
                try managedObjectContext.save()
            } catch{
                
            }
            profileTable.reloadData()
        }
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

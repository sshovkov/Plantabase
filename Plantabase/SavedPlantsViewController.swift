//
//  SavedPlantsViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 3/21/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit
import CoreData

class SavedPlantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var addNewPlantBtn: UIButton!
    @IBOutlet weak var plantTable: UITableView!
    
    var mp:ModelPlant?
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayOfPlants = [PlantEntity]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        mp = ModelPlant(context: managedObjectContext)
        arrayOfPlants = mp!.fetchRecords()
        addNewPlantBtn.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfPlants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "plantCell", for: indexPath) as! PlantTableViewCell
        cell.layer.borderWidth = 0
        cell.plantName.text = arrayOfPlants[indexPath.row].plantName
        let picture = arrayOfPlants[indexPath.row].plantPicture
        cell.plantPic.image = UIImage(data: picture!)
        return cell
    }
    
    @IBAction func addNewPlantBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add New Plant", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter name of new plant here"
        })
        self.present(alert, animated: true, completion: nil)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        let addOption = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let name = alert.textFields?.first?.text {
                switch name.uppercased() {
                case "MONSTERA", "MONSTERA DELICIOSA", "SWISS CHEESE PLANT", "SWISS CHEESE", "PHILODENDRON":
                    let imageData = UIImage(named: "monstera.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "RUBBER", "RUBBER TREE":
                    let imageData = UIImage(named: "rubber.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "ALOE", "ALOE VERA":
                    let imageData = UIImage(named: "aloe.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "CALATHEA", "PRAYER PLANT":
                    let imageData = UIImage(named: "calathea.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "BIRD OF PARADISE":
                    let imageData = UIImage(named: "paradise.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "SNAKE PLANT":
                    let imageData = UIImage(named: "snake.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "POTHOS", "GOLDEN POTHOS", "MARBLE POTHOS":
                   let imageData = UIImage(named: "pothos.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "FIDDLE LEAF FIG":
                    let imageData = UIImage(named: "fiddle.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                case "PILEA":
                    let imageData = UIImage(named: "pilea.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                default:
                    let imageData = UIImage(named: "default.jpg")
                    self.mp?.SaveContext(plantNameInput: name, plantPicInput: (imageData?.pngData())!)
                }
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(addOption)
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

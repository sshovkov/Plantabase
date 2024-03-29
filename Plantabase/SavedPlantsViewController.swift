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
            managedObjectContext.delete(arrayOfPlants[indexPath.row])
            arrayOfPlants.remove(at: indexPath.row)
            
            do {
                try managedObjectContext.save()
            } catch{
                
            }
            plantTable.reloadData()
        }
    }
    
    @IBAction func addNewPlantBtn(_ sender: UIButton) {
        let alert = UIAlertController(title: "Add New Plant", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter name of new plant here"
        })
    
        let addOption = UIAlertAction(title: "Add", style: .default) { (action) in
            if let addedName = alert.textFields?.first?.text {
                self.addToTable(name: addedName)
                self.arrayOfPlants = self.mp!.fetchRecords()
                self.plantTable.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in }
        
        alert.addAction(cancelAction)
        alert.addAction(addOption)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addToTable(name: String) {
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedIndex: IndexPath = self.plantTable.indexPath(for: sender as! UITableViewCell)!
        let plant = arrayOfPlants[selectedIndex.row]
        if(segue.identifier == "plantDetailView"){
            if let viewController: PlantDetailsViewController = segue.destination as? PlantDetailsViewController {
                viewController.selectedPlantName = plant.plantName
                viewController.selectedPlantPic = UIImage(data: plant.plantPicture!)
            }
        }
    }

}

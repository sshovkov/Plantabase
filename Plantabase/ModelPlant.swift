//
//  ModelPlant.swift
//  Plantabase
//
//  Created by Shovkovy on 4/19/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import CoreData

public class ModelPlant {
    
    let managedObjectContext:NSManagedObjectContext?
    var fetchResults = [PlantEntity]()
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    
    func SaveContext(plantNameInput: String, plantPicInput: Data)
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "PlantEntity", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let newItem = PlantEntity(entity: ent!, insertInto: managedObjectContext)
        
        // add data to each field in the entity
        newItem.plantName = plantNameInput
        newItem.plantPicture = plantPicInput
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("\(plantNameInput) has been saved to coredata")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchRecords() -> Array<PlantEntity>{
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlantEntity")
        let sort = NSSortDescriptor(key: "plantName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext!.fetch(fetchRequest)) as? [PlantEntity])!
        
        return fetchResults
    }

}


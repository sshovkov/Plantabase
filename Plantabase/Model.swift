//
//  Model.swift
//  Plantabase
//
//  Created by Shovkovy on 4/13/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import CoreData

public class Model {
    let managedObjectContext:NSManagedObjectContext?
    var fetchResults = [UserEntity]()
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    
    func SaveContext(userName: String, userPlant: String, UserPic: Data)
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "UserEntity", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let newItem = UserEntity(entity: ent!, insertInto: managedObjectContext)
        
        // add data to each field in the entity
        newItem.name = userName
        newItem.favePlant = userPlant
        newItem.picture = UserPic
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("User Saved")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchRecords() -> Array<UserEntity>{
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserEntity")
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext!.fetch(fetchRequest)) as? [UserEntity])!
        
        return fetchResults
    }
}

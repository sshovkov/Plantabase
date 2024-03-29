//
//  ModelShop.swift
//  Plantabase
//
//  Created by Shovkovy on 4/16/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import CoreData

public class ModelShop {
    
    let managedObjectContext:NSManagedObjectContext?
    var fetchResults = [ShopListEntity]()
    
    init(context: NSManagedObjectContext)
    {
        managedObjectContext = context
        
        // Getting a handler to the coredata managed object context
    }
    
    func SaveContext(name: String)
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "ShopListEntity", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let newItem = ShopListEntity(entity: ent!, insertInto: managedObjectContext)
        
        // add data to each field in the entity
        newItem.shopName = name
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("\(name) has been saved to coredata")
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func fetchRecords() -> Array<ShopListEntity>{
        // Create a new fetch request using the FruitEntity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ShopListEntity")
        let sort = NSSortDescriptor(key: "shopName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        // Execute the fetch request, and cast the results to an array of FruitEnity objects
        fetchResults = ((try? managedObjectContext!.fetch(fetchRequest)) as? [ShopListEntity])!
        
        return fetchResults
    }

}

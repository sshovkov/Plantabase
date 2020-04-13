//
//  User+CoreDataClass.swift
//  Plantabase
//
//  Created by Shovkovy on 4/13/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class UserEntity: NSManagedObject {
    
    
    
    func SaveContext(name: String, favePlant: String)
    {
        // get a handler to the Contacts entity through the managed object context
        let ent = NSEntityDescription.entity(forEntityName: "Contacts", in: self.managedObjectContext!)
        
        // create a contact object instance for insert
        let user = UserEntity(entity: ent!, insertInto: managedObjectContext)
        
        user.name = name
        user.favePlant = favePlant
        
        
        // save the new entity
        do {
            try managedObjectContext!.save()
            print("Contact Saved")
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
    }
    

}

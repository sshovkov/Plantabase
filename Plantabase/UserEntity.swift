//
//  Users.swift
//  Plantabase
//
//  Created by Shovkovy on 4/13/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import CoreData

public class UserEntity: NSManagedObject {
    
    @NSManaged public var name: String?
    @NSManaged public var favePlant: String?
}

//
//  PlantEntityswift.swift
//  Plantabase
//
//  Created by Shovkovy on 4/19/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import CoreData

public class PlantEntity: NSManagedObject {
    
    @NSManaged public var plantName: String?
    @NSManaged public var plantPicture: Data?
}

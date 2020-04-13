//
//  User+CoreDataProperties.swift
//  Plantabase
//
//  Created by Shovkovy on 4/13/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var favePlant: String?
    @NSManaged public var name: String?

}

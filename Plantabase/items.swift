//
//  items.swift
//  Plantabase
//
//  Created by Shovkovy on 4/12/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation

class items
{
    var items:[item] = []
    
    init() { }
}

class item
{
    var itemName:String?
    
    init(itName: String) {
        itemName = itName
    }
}

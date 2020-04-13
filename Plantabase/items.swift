//
//  items.swift
//  Plantabase
//
//  Created by Shovkovy on 4/12/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation
import MapKit

class items
{
    var items:[item] = []
    
    init() { }
}

class item
{
    var itemName:String?
    var itemLat:CLLocationDegrees?
    var itemLon:CLLocationDegrees?
    var itemPhoneNum:String?
    var itemURL:URL?
    
    init(itName: String, itLat: CLLocationDegrees, itLon: CLLocationDegrees, phoNum: String, itURL: URL) {
        itemName = itName
        itemLat = itLat
        itemLon = itLon
        itemPhoneNum = phoNum
        itemURL = itURL
    }
}

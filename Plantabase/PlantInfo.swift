//
//  PlantInfo.swift
//  Plantabase
//
//  Created by Shovkovy on 4/19/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import Foundation

public class PlantInfo {
    
    let selectedPlantName:String
    
    init(name: String) {
        selectedPlantName = name
    }
    
    var lightInfo:String = ""
    var waterInfo:String = ""
    var tipInfo:String = ""
    
    func plantCareInfo() -> (String, String, String){
        switch selectedPlantName.uppercased() {
        case "SNAKE PLANT":
            lightInfo = "Thrives in medium to low indirect light. Not suited for intense, direct sun."
            waterInfo = "Water every 2-3 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "This plant is known for its air purifying capabilities."
        case "POTHOS", "GOLDEN POTHOS", "MARBLE POTHOS":
            lightInfo = "Thrives in medium to bright indirect light, but can tolerate low indirect light."
            waterInfo = "Water every 1-2 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "This plant can be propagated in water."
        case "MONSTERA", "MONSTERA DELICIOSA", "PHILODENDRON", "SWISS CHEESE PLANT":
            lightInfo = "Thrives in bright to medium indirect light. Not usually suited for direct sun but can be acclimated to withstand it."
            waterInfo = "Water every 1-2 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "This plant's leaves gain their famous holes as they mature."
        case "PILEA":
            lightInfo = "Thrives in bright direct light, but can tolerate bright to medium indirect light."
            waterInfo = "Water every 2-3 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "This plant is pet-friendly!"
        case "CALATHEA", "PRAYER PLANT":
            lightInfo = "Thrives in medium to bright indirect light, but can tolerate low indirect light."
            waterInfo = "Water every 1-2 weeks, allowing soil to dry out half way down between waterings. Increase frequency with increased light."
            tipInfo = "This plant is pet-friendly!"
        case "FIDDLE LEAF FIG":
            lightInfo = "Thrives in bright indirect light to full sun. A few hours of full sun is preferred."
            waterInfo = "Water every 1-2 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "This plant can grow over 40ft in its native environment."
        case "ALOE", "ALOE VERA":
            lightInfo = "Thrives in bright indirect light to full sun. A few hours of full sun is preferred."
            waterInfo = "Water every 2-3 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "A south- or west-facing outdoor area and slightly sandy soil are ideal conditions"
        case "BIRD OF PARADISE":
            lightInfo = "Thrives in bright to medium indirect light, but can tolerate low indirect light."
            waterInfo = "Water every 1-2 weeks, allowing soil to dry out between waterings. Increase frequency with increased light."
            tipInfo = "Boasts a stunning display of large tropical leaves that in the wilds of southern Africa can reach up to 20' tall! "
        case "RUBBER TREE PLANT", "RUBBER TREE":
            lightInfo = "Thrives in bright light but prefers indirect light that isn’t too hot."
            waterInfo = "Keep moist during the growing season and water only twice a month during the dormant season."
            tipInfo = "Cut a slit in the node where a leaf fell off to allow a new leaf to grow quicker."
        default:
            lightInfo = "No light information on this plant available yet!"
            waterInfo = "No water information on this plant available yet!"
            tipInfo = "No pro tips on this plant available yet!"
        }
        
        return (lightInfo, waterInfo, tipInfo)
    }
    
}

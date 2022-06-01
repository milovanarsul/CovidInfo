//
//  TravelAdvice.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import Foundation
import UIKit

class TravelAdvice: Codable{
    var areaAccessRestriction: TravelAdivce_AreaAccessRestriction?
    var diseaseCases: TravelAdvice_DiseasesCases?
    var areaPolicy: TravelAdvice_AreaPolicy?
    var diseaseInfection: TravelAdvice_DiseaseInfection?
    var diseaseRiskLevel: String?
}

///------------------------------Area Access Restrictions------------------------------

class TravelAdivce_AreaAccessRestriction: Codable {
    var diseaseVaccination: TravelAdivce_AreaAccessRestriction_DiseaseVaccination?
    var exit: TravelAdivce_AreaAccessRestriction_Exit?
    var quarantineModality: TravelAdivce_AreaAccessRestriction_QuarantineModality?
    var entry: TravelAdivce_AreaAccessRestriction_Entry?
    var mask: TravelAdivce_AreaAccessRestriction_Mask?
    var diseaseTesting: TravelAdivce_AreaAccessRestriction_DiseaseTesting?
}

class TravelAdivce_AreaAccessRestriction_DiseaseVaccination: Codable {
    var text: String?
    var isRequired: String?
    var qualifiedVaccines: [String]?
}

class TravelAdivce_AreaAccessRestriction_Exit: Codable{
    var specialRequirements: String?
    var isBanned: String?
}

class TravelAdivce_AreaAccessRestriction_QuarantineModality: Codable{
    var eligiblePerson: String?
}

class TravelAdivce_AreaAccessRestriction_Entry: Codable {
    var text: String?
    var ban: String?
}

class TravelAdivce_AreaAccessRestriction_Mask: Codable {
    var isRequired: String?
    var text: String?
}

class TravelAdivce_AreaAccessRestriction_DiseaseTesting: Codable{
    var isRequired: String?
}



class TravelAdvice_DiseasesCases: Codable{
    var deaths: Int?
    var confirmed: Int?
}

class TravelAdvice_AreaPolicy: Codable{
    var status: String?
    var text: String?
}

class TravelAdvice_DiseaseInfection: Codable{
    var level: String?
    var rate: Double?
}

let greenColor = UIColor("#4aa47a")
let redColor = UIColor("#c0504a")
let yellowColor = UIColor("#f2bf57")

let risksLocalizable: [String : [String : UIColor]] = [
    "Extreme" : ["Extrem" : redColor],
    "High" : ["Ridicat": redColor],
    "Medium" : ["Mediu": yellowColor],
    "Moderate" : ["Moderat": greenColor],
    "Low" : ["Scazut": greenColor],
    "Lockdown" : ["Carantina": redColor],
    "Curfew" : ["Restrictii de circulatie" : redColor],
    "Distancing" : ["Distantare sociala" : signatureDarkBlue],
    "None" : ["Nu este cazul" : greenColor],
    "Partial" : ["Partial" : yellowColor],
    "Partial Measures" : ["Masuri partiale" : yellowColor],
    "Opening" : ["Restrictii relaxate" : yellowColor],
    "Closing" : ["Restrictii inasprite" : redColor],
    "Open" : ["Circulatie libera" : greenColor],
    "Yes" : ["Da" : redColor],
    "No": ["Nu" : greenColor],
    "no": ["Nu" : greenColor],
    "Recommended" : ["Recomandat" : signatureDarkBlue]
]

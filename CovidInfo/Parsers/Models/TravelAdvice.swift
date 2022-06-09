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

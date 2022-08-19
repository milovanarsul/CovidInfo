//
//  TravelAdvice.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import Foundation
import UIKit

class TravelAdvice: Codable {
    let areaAccessRestriction: AreaAccessRestriction?
    let areaPolicy: AreaPolicy?
    let diseaseCases: DiseaseCases?
    let diseaseRiskLevel: DiseaseRiskLevel?
    let diseaseInfection: DiseaseInfection?
}

// MARK: - AreaAccessRestriction
class AreaAccessRestriction: Codable {
    var exit: Exit? = nil
    let travelVaccination: TravelVaccination?
    let masks, tracingApplication, declarationDocuments: DeclarationDocuments?
    let areaHealthPass: AreaHealthPass?
    let entry: Entry?
    let travelQuarantineModality: TravelQuarantineModality?
    let travelTest: TravelTest?
}

// MARK: - AreaHealthPass
class AreaHealthPass: Codable {
    let lastUpdate: String?
    let referenceLink: String?
    let isRequired, applicationGuidance, obtentionMethods: String?
}

// MARK: - DeclarationDocuments
class DeclarationDocuments: Codable {
    let lastUpdate, isRequired, text: String?
}

// MARK: - Entry
class Entry: Codable {
    let text, lastUpdate: String?
    let referenceLink: String?
    let borderBan: [BorderBan]?
    let ban: String?
}

// MARK: - BorderBan
class BorderBan: Codable {
    let borderType, status: String?
}

// MARK: - Exit
class Exit: Codable {
    let isBanned, lastUpdate, specialRequirements: String?
}

// MARK: - Transportation
class Transportation: Codable {
    let text, lastUpdate, isBanned, transportationType: String?
    let throughDate: String?
}

// MARK: - TravelQuarantineModality
class TravelQuarantineModality: Codable {
    let mandateList: String?
    let lastUpdate, eligiblePerson: String?
}

// MARK: - TravelTest
class TravelTest: Codable {
    let lastUpdate, isRequired: String?
}

// MARK: - TravelVaccination
class TravelVaccination: Codable {
    let qualifiedVaccines: [QualifiedVaccine]?
    let vaccinatedTravellers: VaccinatedTravellers?
    let referenceLink: String?
    let details, isRequired, lastUpdate: String?
}

// MARK: - QualifiedVaccine
class QualifiedVaccine: Codable {
    let numberOfDoses: Int?
    let boosterExpiration, expiration: Expiration?
    let validity: Validity?
    let supportedVaccineProducts: String?
    let boosterRequired: String?
}

// MARK: - Expiration
class Expiration: Codable {
    let expiresAfter: String?
}

// MARK: - Validity
class Validity: Codable {
    let delay: String?
}

// MARK: - VaccinatedTravellers
class VaccinatedTravellers: Codable {
    let policy: String?
}

// MARK: - AreaPolicy
class AreaPolicy: Codable {
    let startDate, status, lastUpdate: String?
    let referenceLink: String?
    let endDate, text: String?
}

// MARK: - DiseaseCases
class DiseaseCases: Codable {
    let deaths: Int?
    let lastUpdate: String?
    let confirmed: Int?
}

// MARK: - DiseaseInfection
class DiseaseInfection: Codable {
    let lastUpdate, level, trend: String?
    let rate: Double?
}

// MARK: - DiseaseRiskLevel
class DiseaseRiskLevel: Codable {
    let text: String?
}

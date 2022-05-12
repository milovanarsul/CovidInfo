//
//  CurrentData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.05.2022.
//

import Foundation
import CoreData

class CurrentData: Codable{
    var continent: String? //
    var location: String?  //
    var population: Double? //
    var median_age: Double? //
    var cardiovasc_death_rate: Double? //
    var diabetes_prevalence: Double? //
    var hospital_beds_per_thousand: Double? //
}


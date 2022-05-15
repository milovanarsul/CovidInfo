//
//  CountryData+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//
//

import Foundation
import CoreData


extension CountryData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryData> {
        return NSFetchRequest<CountryData>(entityName: "CountryData")
    }

    @NSManaged public var continent: String?
    @NSManaged public var location: String?
    @NSManaged public var population: Double
    @NSManaged public var median_age: Double
    @NSManaged public var cardiovasc_death_rate: Double
    @NSManaged public var hospital_beds_per_thousand: Double
    @NSManaged public var countryISO: String?
    @NSManaged public var diabetes_prevalence: Double

}

extension CountryData : Identifiable {

}

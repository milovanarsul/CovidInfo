//
//  OWIDStatistics+CoreDataProperties.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//
//

import Foundation
import CoreData


extension OWIDStatistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OWIDStatistics> {
        return NSFetchRequest<OWIDStatistics>(entityName: "OWIDStatistics")
    }

    @NSManaged public var continent: String?
    @NSManaged public var excess_mortality: Double
    @NSManaged public var excess_mortality_cumulative: Double
    @NSManaged public var excess_mortality_cumulative_absolute: Double
    @NSManaged public var excess_mortality_cumulative_per_million: Double
    @NSManaged public var hosp_patients: Double
    @NSManaged public var hosp_patients_per_million: Double
    @NSManaged public var icu_patients: Double
    @NSManaged public var icu_patients_per_million: Double
    @NSManaged public var last_updated_date: String?
    @NSManaged public var location: String?
    @NSManaged public var new_cases: Double
    @NSManaged public var new_cases_per_million: Double
    @NSManaged public var new_cases_smoothed: Double
    @NSManaged public var new_cases_smoothed_per_million: Double
    @NSManaged public var new_deaths: Double
    @NSManaged public var new_deaths_per_million: Double
    @NSManaged public var new_deaths_smoothed: Double
    @NSManaged public var new_deaths_smoothed_per_million: Double
    @NSManaged public var new_people_vaccinated_smoothed: Double
    @NSManaged public var new_people_vaccinated_smoothed_per_hundred: Double
    @NSManaged public var new_tests: Double
    @NSManaged public var new_tests_per_thousand: Double
    @NSManaged public var new_tests_smoothed: Double
    @NSManaged public var new_tests_smoothed_per_thousand: Double
    @NSManaged public var new_vaccinations: Double
    @NSManaged public var new_vaccinations_smoothed: Double
    @NSManaged public var new_vaccinations_smoothed_per_million: Double
    @NSManaged public var people_fully_vaccinated: Double
    @NSManaged public var people_fully_vaccinated_per_hundred: Double
    @NSManaged public var people_vaccinated: Double
    @NSManaged public var people_vaccinated_per_hundred: Double
    @NSManaged public var positive_rate: Double
    @NSManaged public var reproduction_rate: Double
    @NSManaged public var stringency_index: Double
    @NSManaged public var tests_per_case: Double
    @NSManaged public var tests_units: Double
    @NSManaged public var total_boosters: Double
    @NSManaged public var total_boosters_per_hundred: Double
    @NSManaged public var total_cases: Double
    @NSManaged public var total_cases_per_million: Double
    @NSManaged public var total_deaths: Double
    @NSManaged public var total_deaths_per_million: Double
    @NSManaged public var total_tests: Double
    @NSManaged public var total_tests_per_thousand: Double
    @NSManaged public var total_vaccinations: Double
    @NSManaged public var total_vaccinations_per_hundred: Double
    @NSManaged public var weekly_hosp_admissions: Double
    @NSManaged public var weekly_hosp_admissions_per_million: Double
    @NSManaged public var weekly_icu_admissions: Double
    @NSManaged public var weekly_icu_admissions_per_million: Double

}

extension OWIDStatistics : Identifiable {

}

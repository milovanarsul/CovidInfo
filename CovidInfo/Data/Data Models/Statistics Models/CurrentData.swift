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
    var location: String? //
    var last_updated_date: String?
    var total_cases: Double?
    var new_cases: Double?
    var new_cases_smoothed: Double?
    var total_deaths: Double?
    var new_deaths: Double?
    var new_deaths_smoothed: Double?
    var total_cases_per_million: Double?
    var new_cases_per_million: Double?
    var new_cases_smoothed_per_million: Double?
    var vartotal_deaths_per_million: Double?
    var new_deaths_per_million: Double?
    var new_deaths_smoothed_per_million: Double?
    var reproduction_rate: Double?
    var icu_patients: Double?
    var icu_patients_per_million: Double?
    var hosp_patients: Double?
    var hosp_patients_per_million: Double?
    var weekly_icu_admissions: Double?
    var weekly_icu_admissions_per_million: Double?
    var weekly_hosp_admissions: Double?
    var weekly_hosp_admissions_per_million: Double?
    var total_tests: Double?
    var new_tests: Double?
    var total_tests_per_thousand: Double?
    var new_tests_per_thousand: Double?
    var new_tests_smoothed: Double?
    var new_tests_smoothed_per_thousand: Double?
    var positive_rate: Double?
    var tests_per_case: Double?
    var tests_units: Double?
    var total_vaccinations: Double?
    var people_vaccinated: Double?
    var people_fully_vaccinated: Double?
    var total_boosters: Double?
    var new_vaccinations: Double?
    var new_vaccinations_smoothed: Double?
    var total_vaccinations_per_hundred: Double?
    var people_vaccinated_per_hundred: Double?
    var people_fully_vaccinated_per_hundred: Double?
    var total_boosters_per_hundred: Double?
    var new_vaccinations_smoothed_per_million: Double?
    var new_people_vaccinated_smoothed: Double?
    var new_people_vaccinated_smoothed_per_hundred: Double?
    var stringency_index: Double?
    //
    var population: Double?
    var population_density: Double?
    var median_age: Double?
    var aged_65_older: Double?
    var aged_70_older: Double?
    var gdp_per_capita: Double?
    var extreme_poverty: Double?
    var cardiovasc_death_rate: Double?
    var diabetes_prevalence: Double?
    var female_smokers: Double?
    var male_smokers: Double?
    var handwashing_facilities: Double?
    var hospital_beds_per_thousand: Double?
    var life_expectancy: Double?
    var human_development_index: Double?
    //
    var excess_mortality_cumulative_absolute: Double?
    var excess_mortality_cumulative: Double?
    var excess_mortality: Double?
    var excess_mortality_cumulative_per_million: Double?
}


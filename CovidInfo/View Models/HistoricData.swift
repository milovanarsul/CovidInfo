//
//  HistoricData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//

import Foundation

class HistoricData: Codable{
    var data: [HistoricData]
}

class HistoricDataData: Codable {
    var date: String?
    var total_cases: Double?
    var new_cases: Double?
    var new_cases_smoothed: Double?
    var total_deaths: Double?
    var new_deaths: Double?
    var new_deaths_smoothed: Double?
    var total_cases_per_million: Double?
    var new_cases_per_million: Double?
    var new_cases_smoothed_per_million: Double?
    var total_deaths_per_million: Double?
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
    var tests_units: String?
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
    var excess_mortality_cumulative_absolute: Double?
    var excess_mortality_cumulative: Double?
    var excess_mortality: Double?
    var excess_mortality_cumulative_per_million: Double?
}

func parseHistoricDataJSON() -> [String : HistoricData]?{
    do {
        if let filePath = Bundle.main.path(forResource: "historicalData-shrinked", ofType: "json"){
            let fileURL = URL(fileURLWithPath: filePath)
            let data = try Data(contentsOf: fileURL)
            let stats = try JSONDecoder().decode([String : HistoricData].self, from: data)
            return stats
        }
    }
    catch{
        print(error)
    }
    
    return nil
}

//
//  OWIDManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import Foundation

func parseCurrentData(){
    
    if let url = URL(string: "https://covid.ourworldindata.org/data/latest/owid-covid-latest.json"){
        if let data = try? Data(contentsOf: url){
            do{
                var stats = try JSONDecoder().decode([String : DailyData].self, from: data)
                
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                var sortedStats = stats.sorted {$0.key < $1.key}
                stats.removeAll()
                for(key, value) in sortedStats {
                    let data = CurrentData(context: AppDelegate.context)
                    
                    data.countryISO = key
                    data.location = roISOCountries[key]
                
                    if let continent = value.continent {
                        data.continent = continent
                    }

                    if let last_updated_date = value.last_updated_date {
                        data.last_updated_date = last_updated_date
                    }

                    if let total_cases = value.total_cases {
                        data.total_cases = total_cases
                    }

                    if let new_cases = value.new_cases {
                        data.new_cases = new_cases
                    }

                    if let new_cases_smoothed = value.new_cases_smoothed {
                        data.new_cases_smoothed = new_cases_smoothed
                    }

                    if let total_deaths = value.total_deaths {
                        data.total_deaths = total_deaths
                    }

                    if let new_deaths = value.new_deaths {
                        data.new_deaths = new_deaths
                    }

                    if let new_deaths_smoothed = value.new_deaths_smoothed {
                        data.new_deaths_smoothed = new_deaths_smoothed
                    }

                    if let total_cases_per_million = value.total_cases_per_million {
                        data.total_cases_per_million = total_cases_per_million
                    }

                    if let new_cases_per_million = value.new_cases_per_million {
                        data.new_cases_per_million = new_cases_per_million
                    }

                    if let new_cases_smoothed_per_million = value.new_cases_smoothed_per_million {
                        data.new_cases_smoothed_per_million = new_cases_smoothed_per_million
                    }

                    if let total_deaths_per_million = value.total_deaths_per_million {
                        data.total_deaths_per_million = total_deaths_per_million
                    }

                    if let new_deaths_per_million = value.new_deaths_per_million {
                        data.new_deaths_per_million = new_deaths_per_million
                    }

                    if let new_deaths_smoothed_per_million = value.new_deaths_smoothed_per_million {
                        data.new_deaths_smoothed_per_million = new_deaths_smoothed_per_million
                    }

                    if let reproduction_rate = value.reproduction_rate {
                        data.reproduction_rate = reproduction_rate
                    }

                    if let icu_patients = value.icu_patients {
                        data.icu_patients = icu_patients
                    }

                    if let icu_patients_per_million = value.icu_patients_per_million {
                        data.icu_patients_per_million = icu_patients_per_million
                    }

                    if let hosp_patients = value.hosp_patients {
                        data.hosp_patients = hosp_patients
                    }

                    if let hosp_patients_per_million = value.hosp_patients_per_million {
                        data.hosp_patients_per_million = hosp_patients_per_million
                    }

                    if let weekly_icu_admissions = value.weekly_icu_admissions {
                        data.weekly_icu_admissions = weekly_icu_admissions
                    }

                    if let weekly_icu_admissions_per_million = value.weekly_icu_admissions_per_million {
                        data.weekly_icu_admissions_per_million = weekly_icu_admissions_per_million
                    }

                    if let weekly_hosp_admissions = value.weekly_hosp_admissions {
                        data.weekly_hosp_admissions = weekly_hosp_admissions
                    }

                    if let weekly_hosp_admissions_per_million = value.weekly_hosp_admissions_per_million {
                        data.weekly_hosp_admissions_per_million = weekly_hosp_admissions_per_million
                    }

                    if let total_tests = value.total_tests {
                        data.total_tests = total_tests
                    }

                    if let new_tests = value.new_tests {
                        data.new_tests = new_tests
                    }

                    if let total_tests_per_thousand = value.total_tests_per_thousand {
                        data.total_tests_per_thousand = total_tests_per_thousand
                    }

                    if let new_tests_per_thousand = value.new_tests_per_thousand {
                        data.new_tests_per_thousand = new_tests_per_thousand
                    }

                    if let new_tests_smoothed = value.new_tests_smoothed {
                        data.new_tests_smoothed = new_tests_smoothed
                    }

                    if let new_tests_smoothed_per_thousand = value.new_tests_smoothed_per_thousand {
                        data.new_tests_smoothed_per_thousand = new_tests_smoothed_per_thousand
                    }

                    if let positive_rate = value.positive_rate {
                        data.positive_rate = positive_rate
                    }

                    if let tests_per_case = value.tests_per_case {
                        data.tests_per_case = tests_per_case
                    }

                    if let total_vaccinations = value.total_vaccinations {
                        data.total_vaccinations = total_vaccinations
                    }

                    if let people_vaccinated = value.people_vaccinated {
                        data.people_vaccinated = people_vaccinated
                    }

                    if let people_fully_vaccinated = value.people_fully_vaccinated {
                        data.people_fully_vaccinated = people_fully_vaccinated
                    }

                    if let total_boosters = value.total_boosters {
                        data.total_boosters = total_boosters
                    }

                    if let new_vaccinations = value.new_vaccinations {
                        data.new_vaccinations = new_vaccinations
                    }

                    if let new_vaccinations_smoothed = value.new_vaccinations_smoothed {
                        data.new_vaccinations_smoothed = new_vaccinations_smoothed
                    }

                    if let total_vaccinations_per_hundred = value.total_vaccinations_per_hundred {
                        data.total_vaccinations_per_hundred = total_vaccinations_per_hundred
                    }

                    if let people_vaccinated_per_hundred = value.people_vaccinated_per_hundred {
                        data.people_vaccinated_per_hundred = people_vaccinated_per_hundred
                    }

                    if let people_fully_vaccinated_per_hundred = value.people_fully_vaccinated_per_hundred {
                        data.people_fully_vaccinated_per_hundred = people_fully_vaccinated_per_hundred
                    }

                    if let total_boosters_per_hundred = value.total_boosters_per_hundred {
                        data.total_boosters_per_hundred = total_boosters_per_hundred
                    }

                    if let new_vaccinations_smoothed_per_million = value.new_vaccinations_smoothed_per_million {
                        data.new_vaccinations_smoothed_per_million = new_vaccinations_smoothed_per_million
                    }

                    if let new_people_vaccinated_smoothed = value.new_people_vaccinated_smoothed {
                        data.new_people_vaccinated_smoothed = new_people_vaccinated_smoothed
                    }

                    if let new_people_vaccinated_smoothed_per_hundred = value.new_people_vaccinated_smoothed_per_hundred {
                        data.new_people_vaccinated_smoothed_per_hundred = new_people_vaccinated_smoothed_per_hundred
                    }

                    if let stringency_index = value.stringency_index {
                        data.stringency_index = stringency_index
                    }

                    if let population = value.population {
                        data.population = population
                    }

                    if let population_density = value.population_density {
                        data.population_density = population_density
                    }

                    if let median_age = value.median_age {
                        data.median_age = median_age
                    }

                    if let aged_65_older = value.aged_65_older {
                        data.aged_65_older = aged_65_older
                    }

                    if let aged_70_older = value.aged_70_older {
                        data.aged_70_older = aged_70_older
                    }

                    if let gdp_per_capita = value.gdp_per_capita {
                        data.gdp_per_capita = gdp_per_capita
                    }

                    if let cardiovasc_death_rate = value.cardiovasc_death_rate {
                        data.cardiovasc_death_rate = cardiovasc_death_rate
                    }

                    if let diabetes_prevalence = value.diabetes_prevalence {
                        data.diabetes_prevalence = diabetes_prevalence
                    }

                    if let female_smokers = value.female_smokers {
                        data.female_smokers = female_smokers
                    }

                    if let male_smokers = value.male_smokers {
                        data.male_smokers = male_smokers
                    }

                    if let hospital_beds_per_thousand = value.hospital_beds_per_thousand {
                        data.hospital_beds_per_thousand = hospital_beds_per_thousand
                    }

                    if let life_expectancy = value.life_expectancy {
                        data.life_expectancy = life_expectancy
                    }
                    
                    try AppDelegate.context.save()
                }
                sortedStats.removeAll()
            } catch {
                print(error)
            }
        }
    }
}
    
    

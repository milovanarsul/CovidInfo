//
//  OWIDManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import Foundation

func parseCurrentData(){
    let urlString = "https://covid.ourworldindata.org/data/latest/owid-covid-latest.json"
    if let url = URL(string: urlString){
        if let data = try? Data(contentsOf: url){
            do {
                var stats = try JSONDecoder().decode([String : CurrentData].self, from: data)
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                for(key, value) in sortedStats {
                    let data = CountryData(context: AppDelegate.context)
                    data.continent = value.continent
                    data.location = roISOCountries[key]
                    data.countryISO = key
                    
                    if let population = value.population {
                        data.population = population
                    }
                    
                    if let medianAge = value.median_age {
                        data.median_age = medianAge
                    }
                    
                    if let cardioVascDeathRate = value.cardiovasc_death_rate {
                        data.cardiovasc_death_rate = cardioVascDeathRate
                    }
                    
                    if let hospitalBeds = value.hospital_beds_per_thousand {
                        data.hospital_beds_per_thousand = hospitalBeds
                    }
                    
                    if let diabetesPrevalence = value.diabetes_prevalence {
                        data.diabetes_prevalence = diabetesPrevalence
                    }
                    
                    try AppDelegate.context.save()
                }
                } catch {
                print(error)
            }
        }
    }
}

//
//  HistoricalDataManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.05.2022.
//

import Foundation

func parseHistoricalData(){
    let urlString = "https://raw.githubusercontent.com/milovanarsul/CovidInfo/main/Data/data.json"
    if let url = URL(string: urlString){
        if let data = try? Data(contentsOf: url){
            do {
                var stats = try JSONDecoder().decode([String : HistoricalData].self, from: data)
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                for(key, value) in sortedStats {
                    let data = HistoricData(context: AppDelegate.context)
                    
                    data.countryISO = key
                    data.location = roISOCountries[key]
                    
                    if let cases = value.cases {
                        data.cases = cases
                    }
                    
                    if let sevenDaysCases = value.sevenDaysCases {
                        data.sevenDaysCases = sevenDaysCases
                    }
                    
                    if let deaths = value.deaths {
                        data.deaths = deaths
                    }
                    
                    if let sevenDaysDeaths = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysDeaths
                    }
                    
                    if let icu = value.icu {
                        data.icu = icu
                    }
                    
                    if let hospital = value.hospital {
                        data.hospital = hospital
                    }
                    
                    if let test = value.tests {
                        data.tests = test
                    }
                    
                    if let sevenDaysTests = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysTests
                    }
                    
                    if let sevenDaysPositiveRate = value.sevenDaysPositiveRate {
                        data.sevenDaysPositiveRate = sevenDaysPositiveRate
                    }
                    
                    if let vaccinations = value.vaccinations {
                        data.vaccinations = vaccinations
                    }
                    
                    if let sevenDaysVaccinations = value.sevenDaysVaccinations {
                        data.sevenDaysVaccinations = sevenDaysVaccinations
                    }
                    
                    try AppDelegate.context.save()
                    
                }
            } catch {
                print(error)
            }
        }
    }
}

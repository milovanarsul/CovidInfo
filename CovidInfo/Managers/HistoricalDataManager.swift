//
//  HistoricalDataManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.05.2022.
//

import Foundation

func parseHistoricalData(){
    if let url = URL(string: "https://raw.githubusercontent.com/milovanarsul/CovidInfo/main/Data/data2022.json"){
        if let data = try? Data(contentsOf: url){
            do{
                var stats = try JSONDecoder().decode([String : HistoricalData].self, from: data)
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                for(key, value) in sortedStats {
                    let data: HistoricData = HistoricData(context: AppDelegate.context)
                    
                    data.countryISO = key
                    data.location = roISOCountries[key]
                    
                    if let cases = value.cases {
                        data.cases?.perMonth = cases.perMonth
                        data.cases?.All = cases.All
                    }
                    
                    if let sevenDaysCases = value.sevenDaysCases {
                        data.sevenDaysCases = sevenDaysCases
                    }
                    
                    if let deaths = value.deaths {
                        data.deaths?.perMonth = deaths.perMonth
                        data.deaths?.All = deaths.All
                    }
                    
                    if let sevenDaysDeaths = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysDeaths
                    }
                    
                    if let icu = value.icu {
                        data.icu?.perMonth = icu.perMonth
                        data.icu?.All = icu.All
                    }
                    
                    if let hospital = value.hospital {
                        data.hospital?.perMonth = hospital.perMonth
                        data.hospital?.All = hospital.All
                    }
                    
                    if let tests = value.tests {
                        data.tests?.perMonth = tests.perMonth
                        data.tests?.All = tests.All
                    }
                    
                    if let sevenDaysTests = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysTests
                    }
                    
                    if let sevenDaysPositiveRate = value.sevenDaysPositiveRate {
                        data.sevenDaysPositiveRate = sevenDaysPositiveRate
                    }
                    
                    if let vaccinations = value.vaccinations {
                        data.vaccinations?.perMonth = vaccinations.perMonth
                        data.vaccinations?.All = vaccinations.All
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

func parseOldHistoricalData(json: JSONFile){
    do {
        if let bundlePath = Bundle.main.path(forResource: json.rawValue, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
                var stats = try JSONDecoder().decode([String : HistoricalData].self, from: jsonData)
                
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                for(key, value) in sortedStats {
                    let data = OldHistoricData(context: AppDelegate.context)
                    
                    data.countryISO = key
                    data.location = roISOCountries[key]
                    
                    if let cases = value.cases {
                        data.cases?.perMonth = cases.perMonth
                        data.cases?.All = cases.All
                    }
                    
                    if let sevenDaysCases = value.sevenDaysCases {
                        data.sevenDaysCases = sevenDaysCases
                    }
                    
                    if let deaths = value.deaths {
                        data.deaths?.perMonth = deaths.perMonth
                        data.deaths?.All = deaths.All
                    }
                    
                    if let sevenDaysDeaths = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysDeaths
                    }
                    
                    if let icu = value.icu {
                        data.icu?.perMonth = icu.perMonth
                        data.icu?.All = icu.All
                    }
                    
                    if let hospital = value.hospital {
                        data.hospital?.perMonth = hospital.perMonth
                        data.hospital?.All = hospital.All
                    }
                    
                    if let tests = value.tests {
                        data.tests?.perMonth = tests.perMonth
                        data.tests?.All = tests.All
                    }
                    
                    if let sevenDaysTests = value.sevenDaysDeaths {
                        data.sevenDaysDeaths = sevenDaysTests
                    }
                    
                    if let sevenDaysPositiveRate = value.sevenDaysPositiveRate {
                        data.sevenDaysPositiveRate = sevenDaysPositiveRate
                    }
                    
                    if let vaccinations = value.vaccinations {
                        data.vaccinations?.perMonth = vaccinations.perMonth
                        data.vaccinations?.All = vaccinations.All
                    }
                    
                    if let sevenDaysVaccinations = value.sevenDaysVaccinations {
                        data.sevenDaysVaccinations = sevenDaysVaccinations
                    }
                    
                    try AppDelegate.context.save()
                }
            }
        } catch {
        print(error)
    }
}

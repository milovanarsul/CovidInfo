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
                DataManager.historicData = sortedStats
                
                let amadeusCountry = defaults.bool(forKey: "automaticLocation") ? DataManager.automaticLocation : defaults.string(forKey: "manualCountry")!
                AmadeusManager.loadData(country:  countryToISO(country: amadeusCountry!, dictionary: roISOCountries)!){data in
                    AmadeusManager.currentCountryTravelData = data
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
func parseOld2021HistoricalData(){
    do {
        if let bundlePath = Bundle.main.path(forResource: "data2021", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
                var stats = try JSONDecoder().decode([String : OldHistoricalData].self, from: jsonData)
                
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                DataManager.historic2021Data = sortedStats
            }
        } catch {
        print(error)
    }
}

func parseOld2020HistoricalData(){
    do {
        if let bundlePath = Bundle.main.path(forResource: "data2020", ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
                var stats = try JSONDecoder().decode([String : OldHistoricalData].self, from: jsonData)
                
                for (key,_) in stats{
                    if !enISOCountries.keys.contains(key){
                        stats.removeValue(forKey: key)
                    }
                }
                
                let sortedStats = stats.sorted {$0.key < $1.key}
                DataManager.historic2020Data = sortedStats
            }
        } catch {
        print(error)
    }
}

//
//  OWIDManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.05.2022.
//

import Foundation

func parseCurrentData() -> [Dictionary<String, CurrentData>.Element]?{
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
                
                return stats.sorted {$0.key < $1.key}
                } catch {
                print(error)
            }
        }
    }
    
    return nil
}

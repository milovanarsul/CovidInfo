//
//  HistoricalDataManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.05.2022.
//

import Foundation

func parseHistoricalData(json: JSONFile, location: JSONLocation){
    
    var stats: [String : HistoricalData]?
    
    switch location {
    case .local:
        stats = localJSONParser(json: json.rawValue, type: [String : HistoricalData].self)
    case .online:
        stats = onlineJSONParser(json: "https://raw.githubusercontent.com/milovanarsul/CovidInfo/main/Data/data2022.json", type: [String : HistoricalData].self)
    }
    
    for (key,_) in stats!{
        if !enISOCountries.keys.contains(key){
            stats!.removeValue(forKey: key)
        }
    }
    
    let sortedStats = stats!.sorted {$0.key < $1.key}
    for(key, value) in sortedStats {
        
        var data: HistoricData?
        
        switch location {
        case .local:
            data = OldHistoricData(context: AppDelegate.context)
        case .online:
            data = HistoricData(context: AppDelegate.context)
        }
        
        data!.countryISO = key
        data!.location = roISOCountries[key]
        
        if let cases = value.cases {
            data!.cases = cases
        }
        
        if let sevenDaysCases = value.sevenDaysCases {
            data!.sevenDaysCases = sevenDaysCases
        }
        
        if let deaths = value.deaths {
            data!.deaths = deaths
        }
        
        if let sevenDaysDeaths = value.sevenDaysDeaths {
            data!.sevenDaysDeaths = sevenDaysDeaths
        }
        
        if let icu = value.icu {
            data!.icu = icu
        }
        
        if let hospital = value.hospital {
            data!.hospital = hospital
        }
        
        if let test = value.tests {
            data!.tests = test
        }
        
        if let sevenDaysTests = value.sevenDaysDeaths {
            data!.sevenDaysDeaths = sevenDaysTests
        }
        
        if let sevenDaysPositiveRate = value.sevenDaysPositiveRate {
            data!.sevenDaysPositiveRate = sevenDaysPositiveRate
        }
        
        if let vaccinations = value.vaccinations {
            data!.vaccinations = vaccinations
        }
        
        if let sevenDaysVaccinations = value.sevenDaysVaccinations {
            data!.sevenDaysVaccinations = sevenDaysVaccinations
        }
        
        try! AppDelegate.context.save()
                    
    }
}

/*
 
 Showing Recent Messages
 Multiple commands produce '/Users/milovanarsul/Library/Developer/Xcode/DerivedData/CovidInfo-cqflqjvjccaxywftyvvkjkmpxupz/Build/Intermediates.noindex/CovidInfo.build/Debug-iphonesimulator/CovidInfo.build/Objects-normal/arm64/HistoricData+CoreDataClass.o'


 */

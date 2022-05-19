//
//  DataRefreshManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.04.2022.
//

import Foundation

class DataRefreshManager: NSObject {
    static let shared = DataRefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastRefresh"
    private let calendar = Calendar.current
    
    func forceLoadData(){
        DispatchQueue.main.async {
            digi24(articleCount: 40)
            stiriOficiale()
            parseCurrentData()
            parseHistoricalData()
        }
    }
    
    func loadDataIfNeeded(){
        if isRefreshRequired(){
            deleteAllCustomEntityObjects(context: AppDelegate.context)
            DispatchQueue.global(qos: .background).async {
                digi24(articleCount: 40)
                stiriOficiale()
                fetchVariantsData()
                parseCurrentData()
                parseHistoricalData()
            }
            print("data has been refreshed!")
            defaults.set(Date(), forKey: defaultsKey)
        } else {
            print("data has not been refreshed!")
        }
    }
    
    private func isRefreshRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }
        
        if let timeDifference = calendar.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, timeDifference > 24 {
            return true
        } else {
            return false
        }
    }
}

func loadData() -> (CurrentData, HistoricData){
    let automaticCountry: Bool = (AppDelegate.locationCountry != nil)
    let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
    
    var currentData: CurrentData?
    var historicData: HistoricData?
    
    if automaticCountry || manualCountry{
        currentData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getCurrentCountry(name: AppDelegate.locationCountry!): delegates.launch.getCurrentCountry(name: defaults.string(forKey: "manualCountry")!)
        historicData = defaults.bool(forKey: "automaticLocation") ? delegates.launch.getHistoricCountry(name: AppDelegate.locationCountry!): delegates.launch.getHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
    }
    
    //delegates.navigationBar.countrySubtitle(country: (currentData?.location)!, flag: (currentData?.countryISO)!)
    
    return (currentData!, historicData!)
}

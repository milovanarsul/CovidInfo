//
//  DataManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.05.2022.
//

import Foundation
import CoreData

class DataManager{
    ///COVID DATA
    static private let calendar = Calendar.current
    static var currentData: [CurrentData]?
    static var historicData: [HistoricData]?
    static var currentCountryData: CurrentData?
    static var historicCountryData: HistoricData?
    
    static func loadData(){
        parseCurrentData()
        parseHistoricalData()
        parseOldHistoricalData(json: .date2021)
        parseOldHistoricalData(json: .date2020)
        digi24(articleCount: 40)
        stiriOficiale()
        defaults.set(Date(), forKey: "lastRefresh")
        defaults.set(true, forKey: "statisticsFetched")
    }
    
    static func fetchData(){
        DataManager.loadData()
        DataManager.fetchNews()
        DataManager.fetchCovidData()
        DataManager.countryData()
    }
    
    static func fetchCovidData(){
        let currentDataRequest = CurrentData.fetchRequest() as NSFetchRequest<CurrentData>
        let historicDataRequest = HistoricData.fetchRequest() as NSFetchRequest<HistoricData>
        
        do {
            DataManager.currentData = try AppDelegate.context.fetch(currentDataRequest)
            DataManager.historicData = try AppDelegate.context.fetch(historicDataRequest)
        } catch {
            fatalError()
        }
    }
    
    static func countryData(){
        let automaticCountry: Bool = (AppDelegate.locationCountry != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry || manualCountry{
            currentCountryData = defaults.bool(forKey: "automaticLocation") ? getCurrentCountry(name: AppDelegate.locationCountry!): getCurrentCountry(name: defaults.string(forKey: "manualCountry")!)
            historicCountryData = defaults.bool(forKey: "automaticLocation") ? getHistoricCountry(name: AppDelegate.locationCountry!): getHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
        }
    }
    
    static func isRefreshRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: "lastRefresh") as? Date else {
            return true
        }
        
        if let timeDifference = calendar.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, timeDifference > 24 {
            return true
        } else {
            return false
        }
    }
    
    static func getCurrentCountry(name: String) -> CurrentData{
        var currentCountry: CurrentData?
        for country in currentData! {
            if country.location == name{
                currentCountry = country
            }
        }
        
        return currentCountry!
    }
    
    static func getHistoricCountry(name: String) -> HistoricData{
        var historicCountry: HistoricData?
        
        for country in historicData! {
            if country.location == name{
                historicCountry = country
            }
        }

        return historicCountry!
    }
    
    ///NEWS DATA
    
    static var news: [Article]?
    
    static func fetchNews(predicate: NSPredicate? = nil){
        let untrustedSources = NSPredicate(format: "isTrusted == false")
        
        news?.removeAll()
        let request = Article.fetchRequest() as NSFetchRequest<Article>
        
        if let predicate = predicate {
            request.predicate = predicate
        } else {
            request.predicate = untrustedSources
        }
        
        do {
            self.news = try AppDelegate.context.fetch(request)
        } catch {
            fatalError()
        }
    }
}

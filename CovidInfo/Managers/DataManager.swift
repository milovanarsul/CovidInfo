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
    static var historicData: [Dictionary<String, HistoricalData>.Element]?
    
    static var historic2021Data: [Dictionary<String, OldHistoricalData>.Element]?
    static var historic2020Data: [Dictionary<String, OldHistoricalData>.Element]?
    
    static var currentCountryData: CurrentData?
    static var historicCountryData: HistoricalData?
    
    static var currentHistoric2021Data: OldHistoricalData?
    static var currentHistoric2020Data: OldHistoricalData?
    
    static var currentCountry: String?
    
    static func parseData(){
        parseCurrentData()
        parseHistoricalData()
        parseOld2021HistoricalData()
        parseOld2020HistoricalData()
        digi24(articleCount: 40)
        stiriOficiale()
        defaults.set(Date(), forKey: "lastRefresh")
    }
    
    static func fetchCoreData(){
        DataManager.fetchNews()
        DataManager.fetchCovidData()
    }
    
    static func loadAllData(completion: @escaping (_ finished: Bool) -> Void){
        DataManager.setCurrentCountry()
        DataManager.parseData()
        DataManager.fetchCoreData()
        DataManager.countryData()
        FirebaseManager.loadData()
        AmadeusManager.loadData(country: DataManager.currentCountry!, completion: { finished in
            if finished{
                completion(true)
            }
        })
    }
    
    static func loadData(completion: @escaping (_ finished: Bool) -> Void){
        DataManager.setCurrentCountry()
        parseHistoricalData()
        parseOld2021HistoricalData()
        parseOld2020HistoricalData()
        fetchCoreData()
        DataManager.countryData()
        FirebaseManager.loadData()
        AmadeusManager.loadData(country: DataManager.currentCountry!, completion: { finished in
            if finished{
                completion(true)
            }
        })
    }
    
    static func fetchCovidData(){
        let currentDataRequest = CurrentData.fetchRequest() as NSFetchRequest<CurrentData>
        
        do {
            DataManager.currentData = try AppDelegate.context.fetch(currentDataRequest)
        } catch {
            fatalError()
        }
    }
    
    static func setCurrentCountry(){
        if defaults.bool(forKey: "useAutomaticLocation"){
            DataManager.currentCountry = defaults.string(forKey: "automaticCountry")
        } else {
            DataManager.currentCountry = defaults.string(forKey: "manualCountry")
        }
    }
    
    static func countryData(){
        currentCountryData = getCurrentCountry()
        historicCountryData = getHistoricCountry()
        currentHistoric2021Data = getHistoric2021Country()
        currentHistoric2020Data = getHistoric2020Country()
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
    
    static func switchLocation(key: String){
        
    }
    
    static func getCurrentCountry() -> CurrentData{
        var currentCountry: CurrentData?
        for country in currentData! {
            if country.location == DataManager.currentCountry!{
                currentCountry = country
            }
        }
        
        return currentCountry!
    }
    
    static func getHistoricCountry() -> HistoricalData{
        var historicCountry: HistoricalData?
        let location = countryToISO(country: DataManager.currentCountry!, dictionary: roISOCountries)
        
        for (key, value) in historicData! {
            if key == location{
                historicCountry = value
            }
        }

        return historicCountry!
    }
    
    static func getHistoric2021Country() -> OldHistoricalData {
        var historic2021Country: OldHistoricalData?
        let location = countryToISO(country: DataManager.currentCountry!, dictionary: roISOCountries)
        
        for (key, value) in historic2021Data! {
            if key == location{
                historic2021Country = value
            }
        }
        
        return historic2021Country!
    }
    
    static func getHistoric2020Country() -> OldHistoricalData {
        var historic2020Country: OldHistoricalData?
        let location = countryToISO(country: DataManager.currentCountry!, dictionary: roISOCountries)
        
        for (key, value) in historic2021Data! {
            if key == location{
                historic2020Country = value
            }
        }
        
        return historic2020Country!
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
            //self.news = self.news?.sorted(by: {$0.date!.compare($1.date!) == .orderedDescending})
        } catch {
            fatalError()
        }
    }
    
    static func dataResume(currentData: CurrentData) -> [(String, String)]{
        var result = [(String, String)]()
        
        let totalCases = String(format: "%.0f", locale: Locale.current, currentData.total_cases)
        let totalDeaths = String(format: "%.0f", locale: Locale.current, currentData.total_deaths)
        let totalCasesPerMillion = String(currentData.total_cases_per_million)
        let totalDeathsPerMillion = String(currentData.total_deaths_per_million)
        let totalTests = String(format: "%.0f", locale: Locale.current, currentData.total_tests)
        let totalTestsPerThousand = String(currentData.total_tests_per_thousand)
        let totalVaccinations = String(format: "%.0f", locale: Locale.current, currentData.total_vaccinations)
        let totalBoosters = String(format: "%.0f", locale: Locale.current, currentData.total_boosters)
        let totalVaccinationsPerHundred = String(currentData.total_vaccinations_per_hundred)
        let totalBoostersPerHundred = String(currentData.total_boosters_per_hundred)
        
        result = [
            ("Cazuri totale", totalCases),
            ("Decese totale", totalDeaths),
            ("Cazuri totale per milion", totalCasesPerMillion),
            ("Decese totale per milion", totalDeathsPerMillion),
            ("Teste totale", totalTests),
            ("Teste totale per mia de locuitori", totalTestsPerThousand),
            ("Vaccinari totale", totalVaccinations),
            ("Vaccinari totale per suta de locuitori", totalVaccinationsPerHundred),
            ("Boostere totale", totalBoosters),
            ("Boostere totale per suta de locuitori", totalBoostersPerHundred)
        ]
        
        return result
    }
}

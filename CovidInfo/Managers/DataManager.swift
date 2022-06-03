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
    
    static var automaticLocation: String?
    
    //load parsers and webscrapers
    static func loadData(){
        parseCurrentData()
        parseHistoricalData()
        parseOld2021HistoricalData()
        parseOld2020HistoricalData()
        digi24(articleCount: 40)
        stiriOficiale()
        defaults.set(Date(), forKey: "lastRefresh")
        defaults.set(true, forKey: "statisticsFetched")
    }
    
    //load parsers, webscrapers and fetch data from core data
    static func fetchData(){
        deleteAllCustomEntityObjects(context: AppDelegate.context)
        DataManager.loadData()
        DataManager.fetchNews()
        DataManager.fetchCovidData()
        DataManager.countryData()
    }
    
    //fetch data from coredata
    static func fetchCoreData(){
        parseHistoricalData()
        parseOld2021HistoricalData()
        parseOld2020HistoricalData()
        DataManager.fetchNews()
        DataManager.fetchCovidData()
    }
    
    static func fetchCovidData(){
        let currentDataRequest = CurrentData.fetchRequest() as NSFetchRequest<CurrentData>
        
        do {
            DataManager.currentData = try AppDelegate.context.fetch(currentDataRequest)
        } catch {
            fatalError()
        }
    }
    
    static func countryData(){
        let automaticCountry: Bool = (automaticLocation != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry || manualCountry{
            currentCountryData = defaults.bool(forKey: "automaticLocation") ? getCurrentCountry(name: automaticLocation!): getCurrentCountry(name: defaults.string(forKey: "manualCountry")!)
            historicCountryData = defaults.bool(forKey: "automaticLocation") ? getHistoricCountry(name: automaticLocation!): getHistoricCountry(name: defaults.string(forKey: "manualCountry")!)
            currentHistoric2021Data = defaults.bool(forKey: "automaticLocation") ? getHistoric2021Country(name: automaticLocation!): getHistoric2021Country(name: defaults.string(forKey: "manualCountry")!)
            currentHistoric2020Data = defaults.bool(forKey: "automaticLocation") ? getHistoric2020Country(name: automaticLocation!): getHistoric2020Country(name: defaults.string(forKey: "manualCountry")!)
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
    
    static func switchLocation(key: String){
        delegates.main.waitingModal()
        let location = defaults.string(forKey: key)
        
        currentCountryData = getCurrentCountry(name: location!)
        historicCountryData = getHistoricCountry(name: location!)
        currentHistoric2021Data = getHistoric2021Country(name: location!)
        currentHistoric2020Data = getHistoric2020Country(name: location!)
        
        AmadeusManager.loadData(country:  countryToISO(country: location!, dictionary: roISOCountries)!){data in
            AmadeusManager.currentCountryTravelData = data
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0){
            let currentViewController = delegates.tabBar.getCurrentPresentedViewController()
            print(currentViewController)
            
            if currentViewController is HomeViewController {
                
            }
            
            if currentViewController is StatisticsViewController {
                delegates.statistics.refreshTableView()
            }
            
            if currentViewController is InfoViewController {
                print("enters here")
                let presentedViewController = delegates.info.getCardsViewController()
                print(presentedViewController)
                if presentedViewController is CountryViewController {
                    print("enters here too")
                    delegates.countryController.refreshTableView()
                }
            }
            delegates.main.dimissModal(completion: {})
        }
    }
    
    static func isLocationEnabled() -> Bool{
        let automaticCountry: Bool = (automaticLocation != nil)
        let manualCountry: Bool = (defaults.string(forKey: "manualCountry") != nil)
        
        if automaticCountry == false && manualCountry == false{
            return false
        }
        
        return true
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
    
    static func getHistoricCountry(name: String) -> HistoricalData{
        var historicCountry: HistoricalData?
        let location = countryToISO(country: name, dictionary: roISOCountries)
        
        for (key, value) in historicData! {
            if key == location{
                historicCountry = value
            }
        }

        return historicCountry!
    }
    
    static func getHistoric2021Country(name: String) -> OldHistoricalData {
        var historic2021Country: OldHistoricalData?
        let location = countryToISO(country: name, dictionary: roISOCountries)
        
        for (key, value) in historic2021Data! {
            if key == location{
                historic2021Country = value
            }
        }
        
        return historic2021Country!
    }
    
    static func getHistoric2020Country(name: String) -> OldHistoricalData {
        var historic2020Country: OldHistoricalData?
        let location = countryToISO(country: name, dictionary: roISOCountries)
        
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

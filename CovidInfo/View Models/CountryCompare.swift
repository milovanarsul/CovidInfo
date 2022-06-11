//
//  CountryCompare.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.06.2022.
//

import Foundation

class CountryCompareData{
    var total: String?
    var data: [Double]
    var axisData: [String]
    var shouldShow: Bool
    
    init(total: String? = nil, contents: [(String, Double)]){
        if let total = total {
            self.total = total
        }
        
        let refactor = tupleArrayToArrayTuple(dict: contents)
        self.axisData = refactor.0
        self.data = refactor.1
        data.count > 0 ? (self.shouldShow = true) : (self.shouldShow = false)
    }
}

class CountryCompare: ObservableObject{
    var cases: CountryCompareData
    var deaths: CountryCompareData
    var icu: CountryCompareData
    var hospital: CountryCompareData
    var tests: CountryCompareData
    var vaccinations: CountryCompareData
    var visibleCellsCount: Int = 0
    
    init(currentCountry: CurrentData){
        let data2022 = DataManager.getHistoricCountry(customLocation: currentCountry.location)
        let data2021 = DataManager.getHistoric2021Country(customLocation: currentCountry.location)
        let data2020 = DataManager.getHistoric2020Country(customLocation: currentCountry.location)
        
        self.cases = CountryCompareData(total: stringFormatter(data: currentCountry.total_cases), contents: createCountryCompareData(h2022: (data2022.cases?.all)!, h2021: (data2021.cases?.all)!, h2020: (data2020.cases?.all)!))
        self.deaths = CountryCompareData(total: stringFormatter(data: currentCountry.total_deaths), contents: createCountryCompareData(h2022: (data2022.deaths?.all)!, h2021: (data2021.deaths?.all)!, h2020: (data2020.deaths?.all)!))
        self.icu = CountryCompareData(contents: createCountryCompareData(h2022: (data2022.icu?.all)!, h2021: (data2021.icu?.all)!, h2020: (data2020.icu?.all)!))
        self.hospital = CountryCompareData(contents: createCountryCompareData(h2022: (data2022.hospital?.all)!, h2021: (data2021.hospital?.all)!, h2020: (data2020.hospital?.all)!))
        self.tests = CountryCompareData(total: stringFormatter(data: currentCountry.total_tests), contents: createCountryCompareData(h2022: (data2022.tests?.all)!, h2021: (data2021.tests?.all)!, h2020: (data2020.tests?.all)!))
        self.vaccinations = CountryCompareData(total: stringFormatter(data: currentCountry.total_vaccinations), contents: createCountryCompareData(h2022: (data2022.vaccinations?.all)!, h2021: (data2021.vaccinations?.all)!, h2020: (data2020.vaccinations?.all)!))
        
        self.cases.shouldShow ? (self.visibleCellsCount += 1) : ()
        self.deaths.shouldShow ? (self.visibleCellsCount += 1) : ()
        self.icu.shouldShow ? (self.visibleCellsCount += 1) : ()
        self.hospital.shouldShow ? (self.visibleCellsCount += 1) : ()
        self.tests.shouldShow ? (self.visibleCellsCount += 1) : ()
        self.vaccinations.shouldShow ? (self.visibleCellsCount += 1) : ()
    }
}

func createCountryCompareData(h2022: [[String: Double]], h2021: [[String: Double]], h2020: [[String: Double]]) -> [(String, Double)]{
    let historic2020 = dictionaryToTuple(dictionary: h2020)
    let historic2021 = dictionaryToTuple(dictionary: h2021)
    let historic2022 = dictionaryToTuple(dictionary: h2022)
    return [historic2020, historic2021, historic2022].flatMap {$0}
}

//
//  StatisticsData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.04.2022.
//

import Foundation

class StatisticsData {
    var todaysNewCases: Int
    var todaysNewDeaths: Int
    var todaysRecovered: Int
    var totalNumberOfCases: Int
    var totalNumberCured: Int
    var totalNumberDeceased: Int
    var allTimeConfirmedCasesValues: [Double]
    var allTimeCuredCasesValues: [Double]
    var allTimeMortalitiesValues: [Double]
    var casesForTheLastSevenDays: [Double]
    var deathsForTheLastSevenDays: [Double]
    var sevenDaysConfirmedCasesWithDates: [(String, Double)]
    var sevenDaysDeathsWithDates: [(String, Double)]
    var casesForThePastMonth: [(String, Double)]
    var deathsForThePastMonth: [(String, Double)]
    var genderPie: [(String, Double)]
    
    init(todaysNewsCases: Int,
         todaysNewDeaths: Int,
         todaysRecovered: Int,
         totalNumberOfCases: Int,
         totalNumberCured: Int,
         totalNumberDeceased: Int,
         allTimeConfirmedCasesValues: [Double],
         allTimeCuredCasesValues: [Double],
         allTimeMortalitiesValues: [Double],
         casesForTheLastSevenDays: [Double],
         deathsForTheLastSevenDays: [Double],
         sevenDaysConfirmedCasesWithDates: [(String, Double)],
         sevenDaysDeathsWithDates: [(String, Double)],
         casesForThePastMonth: [(String, Double)],
         deathsForThePastMonth: [(String, Double)],
         genderPie: [(String, Double)]
    ){
        self.todaysNewCases = todaysNewsCases
        self.todaysNewDeaths = todaysNewDeaths
        self.todaysRecovered = todaysRecovered
        self.totalNumberOfCases = totalNumberOfCases
        self.totalNumberCured = totalNumberCured
        self.totalNumberDeceased = totalNumberDeceased
        self.allTimeConfirmedCasesValues = allTimeConfirmedCasesValues
        self.allTimeCuredCasesValues = allTimeCuredCasesValues
        self.allTimeMortalitiesValues = allTimeMortalitiesValues
        self.casesForTheLastSevenDays = casesForTheLastSevenDays
        self.deathsForTheLastSevenDays = deathsForTheLastSevenDays
        self.sevenDaysConfirmedCasesWithDates = sevenDaysConfirmedCasesWithDates
        self.sevenDaysDeathsWithDates = sevenDaysDeathsWithDates
        self.casesForThePastMonth = casesForThePastMonth
        self.deathsForThePastMonth = deathsForThePastMonth
        self.genderPie = genderPie
    }
    
    func getPercentage(array: [Double]) -> Int{
        let result = ((array[0] - array[1])/array[1])*100
        return result.toInt()!
    }
    
}

extension Double {
    func toInt() -> Int? {
        let roundedValue = rounded(.toNearestOrEven)
        return Int(exactly: roundedValue)
    }
}

//
//  HistoricData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//

import Foundation

class HistoricalData: Codable{
    var cases: [String : Double]?
    var sevenDaysCases: [String : Double]?
    var deaths: [String : Double]?
    var sevenDaysDeaths: [String : Double]?
    var icu: [String : Double]?
    var hospital: [String : Double]?
    var tests: [String : Double]?
    var sevenDaysTest: [String : Double]?
    var sevenDaysPositiveRate: [String : Double]?
    var vaccinations: [String : Double]?
    var sevenDaysVaccinations: [String : Double]?
}

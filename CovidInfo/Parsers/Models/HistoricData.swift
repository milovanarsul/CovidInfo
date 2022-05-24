//
//  HistoricData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//

import Foundation

public class ObjcHistoricalDataContents: NSObject {
    var perMonth: [String : [String : Double]]?
    var All: [String : Double]?
}

public class HistoricalDataContents: Codable{
    var perMonth: [String : [String : Double]]?
    var All: [String : Double]?
}

class HistoricalData: Codable{
    var cases: HistoricalDataContents?
    var sevenDaysCases: [String : Double]?
    var deaths: HistoricalDataContents?
    var sevenDaysDeaths: [String : Double]?
    var icu: HistoricalDataContents?
    var hospital: HistoricalDataContents?
    var tests: HistoricalDataContents?
    var sevenDaysTest: [String : Double]?
    var sevenDaysPositiveRate: [String : Double]?
    var vaccinations: HistoricalDataContents?
    var sevenDaysVaccinations: [String : Double]?
}

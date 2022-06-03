//
//  HistoricData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 06.05.2022.
//

import Foundation

class HistoricalData: Codable, ObservableObject {
    let cases: Cases?
    let sevenDaysCases: [String : Double]?
    let deaths: Cases?
    let sevenDaysDeaths: [String : Double]?
    let icu, hospital, tests: Cases?
    let sevenDaysTests, sevenDaysPositiveRate: [String : Double]?
    let vaccinations: Cases?
    let sevenDaysVaccinations: [String : Double]?
}

// MARK: - Cases
class Cases: Codable {
    let perMonth: [String: [String: Double]]?
    let all: [String: Double]?

    enum CodingKeys: String, CodingKey {
        case perMonth
        case all = "All"
    }
}

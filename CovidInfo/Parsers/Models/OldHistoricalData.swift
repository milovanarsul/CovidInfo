//
//  OldHistoricalData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import Foundation

class OldHistoricalData: Codable, ObservableObject {
    let cases, deaths, icu, hospital: [String: [String: Double]]
    let tests, vaccinations: [String: [String: Double]]
}

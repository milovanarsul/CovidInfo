//
//  LandscapeManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import Foundation

class LandscapeManager {
    static let shared = LandscapeManager()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}

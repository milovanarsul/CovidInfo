//
//  OnboardingManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.01.2022.
//

import Foundation

class OnboardingManager {
    static let shared = OnboardingManager()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}

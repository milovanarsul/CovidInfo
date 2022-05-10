//
//  Defaults.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import Foundation

var showOnboarding: Bool = false
var articlesViewControllerHasBeenPresented = false
var countryPickerAdded: Bool = false

let defaults = UserDefaults.standard

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

func isFirstLaunch() {
     if OnboardingManager.shared.isFirstLaunch{
         showOnboarding = true
         OnboardingManager.shared.isFirstLaunch = true
     }
}

//
//  Defaults.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import Foundation

class Defaults{
    let defaults = UserDefaults.standard
    
    func setDefaults(){
        defaults.set(true, forKey: "showOnboarding")
        defaults.set(false, forKey: "isCertifficateEnrolled")
    }
    
    func showOnboarding() -> Bool{
        return defaults.bool(forKey: "showOnboarding")
    }
    
    func isCertifficateEnrolled() -> Bool{
        return defaults.bool(forKey: "isCerifficateEnrolled")
    }
}

let defaults = Defaults()

/*
var showOnboarding: Bool = false
var certifficateEnrolled: Bool = false {
    didSet {
        delegates.main.updateCertifficateButton()
    }
}

class Defaults {
    static let shared = Defaults()
    var isFirstLaunch: Bool {
        get {
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
    
    var isCertifficateEnrolled: Bool{
        get{
            !UserDefaults.standard.bool(forKey: #function)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
}

func isFirstLaunch() {
    if Defaults.shared.isFirstLaunch{
        showOnboarding = true
        Defaults.shared.isFirstLaunch = true
    }
}

func isCertifficateEnrolled(){
    if Defaults.shared.isCertifficateEnrolled{
        print("Certifficate: \(Defaults.shared.isCertifficateEnrolled)")
        certifficateEnrolled = true
        Defaults.shared.isCertifficateEnrolled = true
    }
}
*/

//
//  AppDefaults.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.02.2022.
//

import Foundation
import UIKit

var showOnboarding: Bool = false
var articlesViewControllerHasBeenPresented = false
var countryPickerAdded: Bool = false
var dataDownloadFinished: Bool = true

let defaults = UserDefaults.standard

/// UNIVERSAL
let signatureDarkBlue = UIColor("28429E")
let signatureLightBlue = UIColor("91B3FA")
let greenColor = UIColor("#4aa47a")
let redColor = UIColor("#c0504a")
let yellowColor = UIColor("#f2bf57")

/// SIMPTOME & PREVENTIE
let simptomeBorderColor = UIColor("FF3A6C")
let preventieBorderColor = UIColor("02C8AF")

/// TRIAJ
let triajYellow = UIColor("FFD167")
let triajRed = UIColor("D04545")
let actionNormal: CGFloat = 30
let actionSmall: CGFloat = 20

/// LAUNCHSCREEN
let onboardingWidth = 0.883761
let onboardingHeight = 0.550158
let homeHeight: CGFloat = 0.89

/// ANIMATIONS
let defaultAnimationDuration = 0.9

/// CUSTOM NAVIGATION BAR
let defaultNavigationAnimation = 0.7
let parentButtonLeading: CGFloat = -100

/// CUSTOM TAB BAR
let home = "house"
let info = "doc.text.image"
let news = "newspaper"
let statistics = "chart.bar"
let tabBarHeight = 0.0558036


let mainPages: [MainPages:[String:[ChildPages:String]]] = [
    MainPages.info: ["Informatii":[:]],
    MainPages.home: ["Acasa":homePages],
    MainPages.news: ["Stiri":stiriPages],
    MainPages.statistics: ["Statistici":statisticiPages],
]

let homePages: [ChildPages:String] = [
    ChildPages.triaj: "> Triaj",
    ChildPages.preventie: "> Preventie",
    ChildPages.simptome: "> Simptome"
]

let stiriPages: [ChildPages:String] = [:]
let statisticiPages: [ChildPages:String] = [:]
let documentePages: [ChildPages:String] = [:]

let presentationSizes: [PresentationSize:CGFloat] = [
    .small:0.2,
    .medium:0.5,
    .large: 0.9,
    .fullScreen: 1
]

let risksLocalizable: [String : [String : UIColor]] = [
    "Extreme" : ["Extrem" : redColor],
    "High" : ["Ridicat": redColor],
    "Medium" : ["Mediu": yellowColor],
    "Moderate" : ["Moderat": greenColor],
    "Low" : ["Scazut": greenColor],
    "Lockdown" : ["Carantina": redColor],
    "Curfew" : ["Restrictii de circulatie" : redColor],
    "Distancing" : ["Distantare sociala" : signatureDarkBlue],
    "None" : ["Nu este cazul" : greenColor],
    "Partial" : ["Partial" : yellowColor],
    "Partial Measures" : ["Masuri partiale" : yellowColor],
    "Opening" : ["Restrictii relaxate" : yellowColor],
    "Closing" : ["Restrictii inasprite" : redColor],
    "Open" : ["Circulatie libera" : greenColor],
    "Yes" : ["Da" : redColor],
    "No": ["Nu" : greenColor],
    "no": ["Nu" : greenColor],
    "Recommended" : ["Recomandat" : signatureDarkBlue]
]


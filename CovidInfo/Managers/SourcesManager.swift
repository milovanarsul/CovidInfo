//
//  Manager Sources.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.02.2022.
//

import Foundation
import UIKit

let isCertifficateEnrolled: Bool = false

/// UNIVERSAL
let signatureDarkBlue = UIColor("28429E")
let signatureLightBlue = UIColor("91B3FA")

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
let homeHeight: CGFloat = 0.853795
let homeTopConstraint: CGFloat = 90

/// ANIMATIONS
let defaultAnimationDuration = 0.9

/// CUSTOM NAVIGATION BAR
let defaultNavigationAnimation = 0.7
let parentButtonLeading: CGFloat = -100

/// CUSTOM TAB BAR
let home = "house"
let news = "newspaper"
let statistics = "chart.bar"
let documents = "doc.text"
let tabBarHeight = 0.0558036


let mainPages: [MainPages:[String:[ChildPages:String]]] = [
    MainPages.account: ["Cont":[:]],
    MainPages.home: ["Acasa":homePages],
    MainPages.news: ["Stiri":stiriPages],
    MainPages.statistics: ["Statistici":statisticiPages],
    MainPages.documents: ["Documente":documentePages]
]

let homePages: [ChildPages:String] = [
    ChildPages.triaj: "Triaj",
    ChildPages.preventie: "Preventie",
    ChildPages.simptome: "Simptome"
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

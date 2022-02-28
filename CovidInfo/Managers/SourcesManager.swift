//
//  Manager Sources.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.02.2022.
//

import Foundation
import UIKit

let isCertifficateEnrolled: Bool = false

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

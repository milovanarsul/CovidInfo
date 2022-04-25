//
//  SimptomeAndPreventieData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 08.02.2022.
//

import Foundation
import Firebase
import UIKit

class SimptomeAndPreventieData{
    var lottieAnimation: String
    var labelText: String
    
    init(lottieAnimation: String, labelText: String){
        self.lottieAnimation = lottieAnimation
        self.labelText = labelText
    }
}

class SimptomeAndPreventie{
    var cards: [SimptomeAndPreventieData]
    var staticType: StaticType
    var borderColor: UIColor
    
    let databaseReference = Database.database().reference()
    
    init(cards: [SimptomeAndPreventieData], staticType: StaticType, borderColor: UIColor){
        self.cards = cards
        self.staticType = staticType
        self.borderColor = borderColor
    }
}



let simptome = SimptomeAndPreventie(cards: simptomeData, staticType: .simptome, borderColor: simptomeBorderColor)
let preventie = SimptomeAndPreventie(cards: preventieData, staticType: .preventie, borderColor: preventieBorderColor)

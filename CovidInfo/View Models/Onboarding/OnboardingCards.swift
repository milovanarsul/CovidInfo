//
//  OnboardingCardsView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class OnboardingCards: XIB {
    @IBOutlet weak var onboardingCardsView: UIView!
    @IBOutlet weak var label: UILabel!
    
    convenience init(labelText: String){
        self.init()
    
        self.label.text = labelText
    }
}

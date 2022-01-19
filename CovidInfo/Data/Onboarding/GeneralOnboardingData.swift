//
//  GeneralOnboardingData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 14.01.2022.
//

import Foundation

class GeneralOnboardingData{
    var lottieAnimationName: String?
    var animationLabel: String?
    var hasSkipButton: Bool
    
    init(lottieAnimationName: String?, animationLabel: String?, hasSkipButton: Bool){
        self.lottieAnimationName = lottieAnimationName!
        self.animationLabel = animationLabel!
        self.hasSkipButton = hasSkipButton
    }
}

var generalOnboardingData = [
    GeneralOnboardingData(lottieAnimationName: "onboarding1", animationLabel: "Afla cum sa te protejezi si ce simptome pot aparea, ultimele stiri si de unde sa te informezi", hasSkipButton: false),
    GeneralOnboardingData(lottieAnimationName: "onboarding2", animationLabel: "Vizualizeaza ultimele statistici si afla evolutia pandemiei in Romania", hasSkipButton: false),
    GeneralOnboardingData(lottieAnimationName: "onboarding3", animationLabel: "Afla mai multe despre vaccinurile aprobate si cum poti spune stop pandemiei", hasSkipButton: false),
    GeneralOnboardingData(lottieAnimationName: "onboarding4", animationLabel: "Iti poti inrola certificatul de vaccinare pentru a-l avea la indemana", hasSkipButton: true),
    GeneralOnboardingData(lottieAnimationName: "onboarding5", animationLabel: "Poti crea un cont pentru a-ti salva datele intr-un loc sigur", hasSkipButton: true),
]

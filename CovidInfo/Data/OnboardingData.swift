//
//  OnboardingData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import Foundation

public class OnboardingData{
    
    private var lottieAnimation: String
    private var labelText: String
    var isModalNext: Bool
    
    init(lottieAnimation: String, labelText: String, isModalNext: Bool){
        self.lottieAnimation = lottieAnimation
        self.labelText = labelText
        self.isModalNext = isModalNext
    }
    
    public func getLottieAnimation() -> String{
        return lottieAnimation
    }
    
    public func getLabelText() -> String{
        return labelText
    }
}

public var onboardingDataArray = [
    OnboardingData(lottieAnimation: "onboarding1", labelText: "Afla cum sa te protejezi si ce simptome pot aparea, ultimele stiri si de unde sa te informezi", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding2", labelText: "Vizualizeaza ultimele statistici si afla evolutia Pandemiei in Romania", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding3", labelText: "Afla mai multe despre vaccinurile aprobate si cum poti spune stop pandemiei", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding4", labelText: "Iti poti inrola certificatul pentru a-l avea la indemana", isModalNext: true),
    OnboardingData(lottieAnimation: "", labelText: "Certificatul tau a fost inrolat cu succes!", isModalNext: false),
    OnboardingData(lottieAnimation: "onboarding5", labelText: "Poti crea un cont pentru a-ti salva datele intr-un loc sigur", isModalNext: true)
]

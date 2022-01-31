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
    
    init(lottieAnimation: String, labelText: String){
        self.lottieAnimation = lottieAnimation
        self.labelText = labelText
    }
    
    public func getLottieAnimation() -> String{
        return lottieAnimation
    }
    
    public func getLabelText() -> String{
        return labelText
    }
}

public var onboardingDataArray = [
    OnboardingData(lottieAnimation: "onboarding1", labelText: "Afla cum sa te protejezi si ce simptome pot aparea, ultimele stiri si de unde sa te informezi"),
    OnboardingData(lottieAnimation: "onboarding2", labelText: "Vizualizeaza ultimele statistici si afla evolutia Pandemiei in Romania"),
    OnboardingData(lottieAnimation: "onboarding3", labelText: "Afla mai multe despre vaccinurile aprobate si cum poti spune stop pandemiei"),
    OnboardingData(lottieAnimation: "onboarding4", labelText: "Iti poti inrola certificatul pentru a-l avea la indemana"),
    OnboardingData(lottieAnimation: "onboarding5", labelText: "Poti crea un cont pentru a-ti salva datele intr-un loc sigur")
]

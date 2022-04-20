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



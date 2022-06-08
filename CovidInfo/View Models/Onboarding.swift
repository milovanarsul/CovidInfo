//
//  OnboardingData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import Foundation

public class OnboardingData{
    var image: String
    var labelText: String
    var isSkipEnabled: Bool
    
    var nextButtonText: String = "Mai departe"
    var skipButtonText: String = "Mai tarziu"
    
    init(image: String, labelText: String, isSkipEnabled: Bool, nextButtonText: String? = nil, skipButtonText: String? = nil){
        self.image = image
        self.labelText = labelText
        self.isSkipEnabled = isSkipEnabled
        
        if let nextButtonText = nextButtonText {
            self.nextButtonText = nextButtonText
        }
        
        if let skipButtonText = skipButtonText {
            self.skipButtonText = skipButtonText
        }
    }
}



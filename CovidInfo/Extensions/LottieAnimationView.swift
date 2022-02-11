//
//  LottieAnimationView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import Foundation
import Lottie

extension AnimationView{
    func setup(animationName: String, loopMode: LottieLoopMode, animationSpeed: CGFloat){
        self.animation = Animation.named(animationName)
        self.contentMode = .scaleAspectFit
        self.loopMode = .loop
        self.animationSpeed = animationSpeed
    }
}

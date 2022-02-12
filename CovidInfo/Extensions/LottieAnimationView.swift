//
//  LottieAnimationView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import Foundation
import Lottie

extension AnimationView{
    func setup(animationName: String, loopMode: LottieLoopMode, animationSpeed: CGFloat, container: UIView){
        self.animation = Animation.named(animationName)
        self.frame = container.bounds
        self.contentMode = .scaleAspectFit
        self.loopMode = .loop
        self.animationSpeed = animationSpeed
        container.addSubview(self)
        self.play()
    }
}

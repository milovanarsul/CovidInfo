//
//  LottieAnimations.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import Foundation
import Lottie

func startLottieAnimation(lottieAnimationView: AnimationView!){
    lottieAnimationView.contentMode = .scaleAspectFit
    lottieAnimationView.loopMode = .playOnce
    lottieAnimationView.animationSpeed = 0.5
    lottieAnimationView.play()
}

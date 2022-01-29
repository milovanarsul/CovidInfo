//
//  LottieAnimations.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import Foundation
import Lottie
import UIKit

public func setupLottieAnimation(lottieAnimationName: String, parentView: UIView!) -> AnimationView!{
    var lottieAnimation = AnimationView()
    
    lottieAnimation = .init(name: lottieAnimationName)
    
    lottieAnimation.frame = parentView.bounds
    lottieAnimation.contentMode = .scaleAspectFit
    
    lottieAnimation.loopMode = .playOnce
    lottieAnimation.animationSpeed = 0.5
    parentView.addSubview(lottieAnimation)
    
    lottieAnimation.play()
    
    return lottieAnimation
}

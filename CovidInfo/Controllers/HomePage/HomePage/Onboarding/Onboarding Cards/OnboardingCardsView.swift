//
//  OnboardingCardsView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class OnboardingCardsView: UIView {
    @IBOutlet weak var onboardingCardsView: UIView!
    @IBOutlet var lottieAnimation: AnimationView!
    @IBOutlet weak var label: UILabel!
    
    convenience init(lottieAnimationName: String, labelText: String, isLaterButtonEnabled: Bool){
        self.init()
        
        self.setupLottieAnimation(lottieAnimationName: lottieAnimationName)
        self.label.text = labelText
    }
    
    public func setupLottieAnimation(lottieAnimationName: String){
        lottieAnimation = .init(name: lottieAnimationName)
        
        lottieAnimation!.frame = onboardingCardsView.bounds
        lottieAnimation!.contentMode = .scaleAspectFit
        
        lottieAnimation!.loopMode = .playOnce
        lottieAnimation!.animationSpeed = 0.5
        onboardingCardsView.addSubview(lottieAnimation!)
        
        lottieAnimation!.play()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    fileprivate func initWithNib(){
        Bundle.main.loadNibNamed("OnboardingCards", owner: self, options: nil)
        onboardingCardsView.frame = self.bounds
        onboardingCardsView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(onboardingCardsView)
    }
}

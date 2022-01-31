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
    
    public var lottieAnimationName: String?
    
    convenience init(lottieAnimationName: String, labelText: String){
        self.init()
        
        self.lottieAnimationName = lottieAnimationName
        self.label.text = labelText
    }
    
    func lottieAnimationOnboarding(){
        lottieAnimation = .init(name: "onboarding1")
        
        lottieAnimation.frame = self.bounds
        lottieAnimation.contentMode = .scaleAspectFit
        
        lottieAnimation.loopMode = .playOnce
        lottieAnimation.animationSpeed = 0.5
        self.addSubview(lottieAnimation)
        
        lottieAnimation.play()
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

extension OnboardingCardsView: LottieAnimationDelegate{
    func startAnimation() {
        lottieAnimationOnboarding()
    }
    
    func test(){
        print("Delegate works!")
    }
}

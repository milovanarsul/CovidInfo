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
    
    convenience init(lottieAnimationName: String, labelText: String, isLaterButtonEnabled: Bool){
        self.init()
        
        self.lottieAnimation = setupLottieAnimation(lottieAnimationName: lottieAnimationName, parentView: onboardingCardsView)
        self.lottieAnimationName = lottieAnimationName
        self.label.text = labelText
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

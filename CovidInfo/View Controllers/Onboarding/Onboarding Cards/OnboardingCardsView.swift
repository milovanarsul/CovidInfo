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
    @IBOutlet weak var label: UILabel!
    
    convenience init(labelText: String){
        self.init()
    
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

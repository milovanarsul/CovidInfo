//
//  EnrollCertificateView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class EnrollCertificateView: UIView {
    
    @IBOutlet var enrollCertificateView: UIView!
    @IBOutlet var lottieAnimationView: AnimationView!
    
    convenience init(){
        self.init()
        
        self.lottieAnimationView = setupLottieAnimation(lottieAnimationName: "onboarding4.1", parentView: enrollCertificateView)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    fileprivate func initWithNib(){
        Bundle.main.loadNibNamed("EnrollCertificate", owner: self, options: nil)
        enrollCertificateView.frame = self.bounds
        enrollCertificateView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(enrollCertificateView)
    }
    
}

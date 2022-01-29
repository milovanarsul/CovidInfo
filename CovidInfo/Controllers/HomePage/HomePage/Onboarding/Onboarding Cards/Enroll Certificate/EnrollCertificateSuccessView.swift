//
//  EnrollCertificateSuccessView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit
import Lottie

class EnrollCertificateSuccessView: UIView {
    @IBOutlet var enrollCertificateSuccessView: UIView!
    @IBOutlet var lottieAnimationView: AnimationView!
    
    convenience init(){
        self.init()
        
        self.lottieAnimationView = setupLottieAnimation(lottieAnimationName: "onboarding4.2", parentView: enrollCertificateSuccessView)
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
        Bundle.main.loadNibNamed("EnrollCertificateSuccess", owner: self, options: nil)
        enrollCertificateSuccessView.frame = self.bounds
        enrollCertificateSuccessView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(enrollCertificateSuccessView)
    }
    
}

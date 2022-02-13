//
//  OnboardingCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.02.2022.
//

import UIKit
import Lottie

class OnboardingCell: UIViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var animationView: UIView!
    @IBOutlet var label: UILabel!
    @IBOutlet var maiDeparteButton: UIButton!
    @IBOutlet var maiTarziuButton: UIButton!
    
    var animationName: String!
    var labelText: String!
    var isModalNext: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
        self.label.text = self.labelText
        
        if self.isModalNext{
            self.maiTarziuButton.isHidden = false
        }
    }
    
    func setupAnimation(){
        let animation = AnimationView()
        animation.setup(animationName: self.animationName, loopMode: .loop, animationSpeed: 0.5, container: self.animationView)
    }
    
    init(animationName: String, labelText: String, isModalNext: Bool){
        self.animationName = animationName
        self.labelText = labelText
        self.isModalNext = isModalNext
        
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder aDeocoder: NSCoder) {
        super.init(coder: aDeocoder)
    }
    
    @IBAction func maiDeparteButtonTapped(_ sender: Any) {
        self.isModalNext ? delegates.onboarding.modal!():delegates.onboarding.nextPage!()
    }
    
    @IBAction func maiTarziuButtonTapped(_ sender: Any) {
        self.isModalNext ? delegates.onboarding.nextPage!():delegates.onboarding.modal!()
    }
}

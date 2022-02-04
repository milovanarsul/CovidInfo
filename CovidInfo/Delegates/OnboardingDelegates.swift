//
//  GeneralOnboardingDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import Foundation
import Lottie

protocol OnboardingPageViewControllerToOnboardingViewController{
    func nextButtonIsTapped()
}

protocol OnboardingViewControllerToOnboardingPageViewController{
    func showEnrollCertificateButton(show: Bool)
    func showCreateAccountButton(show: Bool)
}

enum AnimationOrigin{
    case launch
    case onboarding
}

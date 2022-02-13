//
//  OnboardingModal.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingModal: XIB {
    @IBAction func cancelButton(_ sender: Any) {
        delegates.onboarding.dismissModal!()
    }
}

//
//  Delegates.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

protocol OnboardingPageViewControllerDelegate{
    func nextButtonIsTapped()
}

protocol OnboardingViewControllerDelegate{
    func showEnrollCertificateButton(show: Bool)
    func showCreateAccountButton(show: Bool)
}

protocol NavigationBarDelegate{
    func setup(page: Page)
}

protocol TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

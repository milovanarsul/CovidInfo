//
//  OnboardingPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit

class OnboardingPageViewController: UIPageViewController {
    
    var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        delegates.onboardingPVC = self
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: false)
        
    }
    
    fileprivate func createViewControllers(){
        let onboardingData = onboardingDataArray
        
        let onboardingWelcomeView = UIViewController()
        onboardingWelcomeView.view = OnboardingWelcomeView()
        pages.append(onboardingWelcomeView)
        
        for data in onboardingData{
            let viewController = UIViewController()
            viewController.view = OnboardingView(data: data)
            pages.append(viewController)
        }
        
        pages.append(OnboardingLocationPicker())
        
        let onboardingDownloadData = UIViewController()
        onboardingDownloadData.view = OnboardingDownloadData()
        pages.append(onboardingDownloadData)
    }
}

extension OnboardingPageViewController: OnboardingPageViewControllerDelegate{
    func getCurrentIndex() -> Int {
        return getCurrentIndex(views: pages)
    }
    
    func nextPage() {
        let currentIndex = getCurrentIndex(views: pages)
        goToIndex(pageIndex: currentIndex + 1, direction: .forward, pages: pages)
        
        switch currentIndex{
        case 0:
            ()
        default:
            delegates.onboarding.setPageControl()
        }
    }
    
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}

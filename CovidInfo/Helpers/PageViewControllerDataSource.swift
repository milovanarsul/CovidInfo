//
//  PageViewControllerDataSource.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.02.2022.
//

import UIKit

class PageViewControllerDataSource: NSObject, UIPageViewControllerDataSource {
    var pages: [UIViewController]
    var pageController: PageController
    
    init(pages: [UIViewController], pageController: PageController){
        self.pages = pages
        self.pageController = pageController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard self.pages.count > previousIndex else {return nil}
        return self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard self.pages.count != nextIndex else {return nil}
        guard self.pages.count > nextIndex else {return nil}
        
        if pageController == .onboarding{
            onboardingActions(viewControllerIndex: viewControllerIndex)
        }
        
        return self.pages[nextIndex]
    }
    
    func onboardingActions(viewControllerIndex: Int){
        if viewControllerIndex == 2{
            delegates.onboarding.showEnrollCertificateButton(show: true)
        }
        
        if viewControllerIndex == 3{
            delegates.onboarding.showCreateAccountButton(show: true)
        }
    }
}

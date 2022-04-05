//
//  MainPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    var currentPresentedViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        delegate = self
        createViewControllers()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViewControllers(){
        
        let homeViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        delegates.homePage = homeViewController
        pages.append(homeViewController)
        
        let newsViewController = NewsViewController()
        pages.append(newsViewController)
        
        let statisticsViewController = StatisticiViewController()
        pages.append(statisticsViewController)
        
        let documentsViewController = DocumenteViewController()
        pages.append(documentsViewController)
    }
}

extension MainPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            currentPresentedViewController = viewControllers?.first
        }
    }
}

extension MainPageViewController: TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
    
    func getCurrentPresentedViewController() -> UIViewController{
        return (viewControllers?.first)!
    }
}

//
//  MainPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        createViewControllers()
        initialize(pages: pages)
    }
    
    fileprivate func createViewControllers(){
        let homeViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        delegates.homeDelegate = homeViewController
        pages.append(homeViewController)
        
        let newsViewController = StiriViewController()
        pages.append(newsViewController)
        
        let statisticsViewController = StatisticiViewController()
        pages.append(statisticsViewController)
        
        let documentsViewController = DocumenteViewController()
        pages.append(documentsViewController)
    }
}

extension MainPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard pages.count > previousIndex else {return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard pages.count != nextIndex else {return nil}
        guard pages.count > nextIndex else {return nil}
        return pages[nextIndex]
    }
}

extension MainPageViewController: TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}

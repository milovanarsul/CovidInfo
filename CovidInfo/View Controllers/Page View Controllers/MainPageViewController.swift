//
//  MainPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class MainPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    
    var navigationBarDelegate: NavigationBarDelegate!
    var homePageDelegate: HomePageDelegate!
    var mainDelegate: MainDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        createViewControllers()
        initialize(pages: pages)
    }
    
    fileprivate func createViewControllers(){
        let homeViewController = HomePageViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        homeViewController.navigationBarDelegate = self.navigationBarDelegate
        homeViewController.mainDelegate = self.mainDelegate
        self.homePageDelegate = homeViewController
        pages.append(homeViewController)
        
        let newsViewController = StiriViewController()
        newsViewController.navigationBarDelegate = self.navigationBarDelegate
        pages.append(newsViewController)
        
        let statisticsViewController = StatisticiViewController()
        statisticsViewController.navigationBarDelegate = self.navigationBarDelegate
        pages.append(statisticsViewController)
        
        let documentsViewController = DocumenteViewController()
        documentsViewController.navigationBarDelegate = self.navigationBarDelegate
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

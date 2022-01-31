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
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        disableSwipeGesture()
    }
    
    fileprivate func createViewControllers(){
        pages.append(HomePageViewController())
        pages.append(StiriViewController())
        pages.append(StatisticiViewController())
        pages.append(DocumenteViewController())
    }
}

extension MainPageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil} //currentIndex
        
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
        
        //actions for delegates go here
       
        return pages[nextIndex]
    }
}

//
//  UIPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import Foundation
import UIKit

extension UIPageViewController {
    func getCurrentIndex(views: [UIViewController]) -> Int{
        guard let currentViewController = viewControllers?.first else {return 0}
        return views.firstIndex(of: currentViewController) ?? 0
    }
    
    func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil){
        guard let currentPage = viewControllers?[0] else {return}
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else {return}
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToIndex(pageIndex: Int, direction: UIPageViewController.NavigationDirection, pages: [UIViewController], animated: Bool? = true){
        let viewController = pages[pageIndex]
        setViewControllers([viewController], direction: direction, animated: animated!, completion: nil)
    }
    
    func initialize(pages: [UIViewController], scroll: Bool){
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
       disableSwipeGesture()
    }
}

class PageViewControllerDataSource: NSObject, UIPageViewControllerDataSource {
    var pages: [UIViewController]
    
    init(pages: [UIViewController]){
        self.pages = pages
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
        
        return self.pages[nextIndex]
    }
}

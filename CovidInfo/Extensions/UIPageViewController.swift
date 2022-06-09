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

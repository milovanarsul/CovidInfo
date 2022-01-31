//
//  UIPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import Foundation
import UIKit

extension UIPageViewController {
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
}

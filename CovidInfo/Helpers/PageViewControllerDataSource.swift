//
//  PageViewControllerDataSource.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.06.2022.
//

import Foundation
import UIKit

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

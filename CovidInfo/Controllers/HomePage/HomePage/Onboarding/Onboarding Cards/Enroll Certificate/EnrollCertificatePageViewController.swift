//
//  EnrollCertificatePageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 29.01.2022.
//

import UIKit

class EnrollCertificatePageViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    fileprivate var content: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        if let firstViewController = content.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func createViewControllers(){
        let firstViewController = UIViewController()
        firstViewController.view = EnrollCertificateView()
        
        let secondViewController = UIViewController()
        secondViewController.view = EnrollCertificateSuccessView()
        
        content.append(firstViewController)
        content.append(secondViewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = content.firstIndex(of: viewController) else {return nil} //currentIndex
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        
        guard content.count > previousIndex else {return nil}
        
        return content[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = content.firstIndex(of: viewController) else {return nil}
        
        let nextIndex = viewControllerIndex + 1
        guard content.count != nextIndex else {return nil}
        
        guard content.count > nextIndex else {return nil}
        
        return content[nextIndex]
    }
}

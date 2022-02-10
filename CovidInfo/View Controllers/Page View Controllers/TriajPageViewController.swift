//
//  TriajPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.02.2022.
//

import UIKit

class TriajPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages, pageController: .triaj)
        dataSource = pageViewControllerDataSource
        createViews()
        initialize(pages: pages)
    }
    
    fileprivate func createViews(){
        let currentIndex = getCurrentIndex(views: pages)
        
        for triaj in triajData{
            let viewController = UIViewController()
            let triajView = Triaj(image: triaj.image, labelText: triaj.mainLabel, labelColor: .black, isBigTitle: true, index: currentIndex)
            viewController.view = triajView
            pages.append(viewController)
        }
    }
}

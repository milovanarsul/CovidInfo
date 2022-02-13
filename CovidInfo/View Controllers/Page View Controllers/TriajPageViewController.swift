//
//  TriajPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class TriajPageViewController: UIPageViewController {

    fileprivate var pages: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.triaj = self
        
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages, pageController: .triaj)
        dataSource = pageViewControllerDataSource
        createViews()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViews(){
        for triaj in triajData{
            pages.append(Triaj(data: triaj))
        }
    }
}

extension TriajPageViewController: TriajDelegate{
    func nextPage() {
        goToIndex(pageIndex: getCurrentIndex(views: pages) + 1, direction: .forward, pages: pages)
    }
}

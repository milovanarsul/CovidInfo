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
    func endTriaj() {
        goToIndex(pageIndex: 0, direction: .reverse, pages: pages, animated: false)
        riskPrecentage = 0
    }
    
    func nextPage(index: Int) {
        goToIndex(pageIndex: index, direction: .forward, pages: pages)
        
        switch index{
        case 6:
            delegates.triajSub.resizeContainerView()
        case 7:
            delegates.triajSub.resetContainerView()
        default:
            ()
        }
    }
    
    func currentIndex() -> Int{
        return getCurrentIndex(views: pages)
    }
    
    func goToStart(){
        goToIndex(pageIndex: 0, direction: .reverse, pages: pages, animated: true)
        riskPrecentage = 0
    }
}

//
//  InfoPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.05.2022.
//

import UIKit

class InfoPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.infoPage = self
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViewControllers(){
        
        let countryViewController = CountryViewController()
        pages.append(countryViewController)
        
        let quickQuestionsViewController = InfoCardsCollectionViewController(infoCardsType: .intrebariFrecvente)
        pages.append(quickQuestionsViewController)
        
        let vaccinationViewController = InfoCardsCollectionViewController(infoCardsType: .vaccinare)
        pages.append(vaccinationViewController)
        
        let variantsViewController = NewsViewController(cardsTableViewType: .variants)
        pages.append(variantsViewController)
    }
}

extension InfoPageViewController: InfoPageViewControllerDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}


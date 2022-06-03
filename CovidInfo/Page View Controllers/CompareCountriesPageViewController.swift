//
//  CompareCountriesPageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 03.06.2022.
//

import UIKit

class CompareCountriesPageViewController: UIPageViewController {

    fileprivate var pages: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.compareCountriesPVC = self
        let pageViewControllerDataSource = PageViewControllerDataSource(pages: pages)
        dataSource = pageViewControllerDataSource
        createViewControllers()
        initialize(pages: pages, scroll: false)
    }
    
    fileprivate func createViewControllers(){
        let country1Result = CompareCountriesResultViewController(data: DataManager.getCurrentCountry(name: country1!.name!))
        pages.append(country1Result)
        
        let country2Result = CompareCountriesResultViewController(data: DataManager.getCurrentCountry(name: country2!.name!))
        pages.append(country2Result)
    }
}

extension CompareCountriesPageViewController: CompareCountriesPageViewControllerDeleagate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
}


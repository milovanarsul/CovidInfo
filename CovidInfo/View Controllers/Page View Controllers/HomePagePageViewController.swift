//
//  HomePagePageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import UIKit

class HomePageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    
    var page: Page = Page(mainPage: .home, childType: .none)
    var navigationBarDelegate: NavigationBarDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarDelegate.setup(page: page)
        
        dataSource = self
        createViews()
        initialize(pages: pages)
    }
    
    fileprivate func createViews(){
        
        let firstViewController = UIViewController()
        let home = Home()
        home.homePageDelegate = self
        home.navigationBarDelegate = self.navigationBarDelegate
        firstViewController.view = home
        pages.append(firstViewController)
        
        let secondViewController = UIViewController()
        let triaj = Triaj()
        triaj.homePageDelegate = self
        secondViewController.view = triaj
        pages.append(secondViewController)
        
        let thirdViewController = UIViewController()
        let simptome = Simptome()
        simptome.homePageDelegate = self
        thirdViewController.view = simptome
        pages.append(thirdViewController)
        
        let fourthViewController = UIViewController()
        let preventie = Preventie()
        preventie.homePageDelegate = self
        fourthViewController.view = preventie
        pages.append(fourthViewController)
    }
}

extension HomePageViewController: UIPageViewControllerDataSource{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard pages.count > previousIndex else {return nil}
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard pages.count != nextIndex else {return nil}
        guard pages.count > nextIndex else {return nil}
        return pages[nextIndex]
    }
}

extension HomePageViewController: HomePageDelegate{
    func updateNavigationBar(page: Page) {
        navigationBarDelegate.setup(page: page)
    }
    
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection) {
        goToIndex(pageIndex: pageIndex, direction: direction, pages: pages)
    }
    
    
}

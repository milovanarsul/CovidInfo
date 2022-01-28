//
//  HomePageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    private var navigationBar: CustomNavigationBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar?.setPageTitles(previousPageTitle: "Acasa", currentPageTitle: "Test")
        

    }
}

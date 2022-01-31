//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var customTabBar: UIView!
    var navigationBarDelegate: NavigationBarDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedCustomNavigationBar()
        navigationBarDelegate.currentPageSettings(shouldShowCurrentPageButton: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {}
    
    func embedCustomNavigationBar(){
        let customNavigationBar = CustomNavigationBar(previousPageTitle: "Acasa", currentPageTitle: "")
        customNavigationBar.frame = self.customNavigationBar.bounds
        navigationBarDelegate = customNavigationBar
        self.customNavigationBar.addSubview(customNavigationBar)
    }
    
    func embedCustomTabBar(){
        let customTabBar = CustomTabBar()
        customTabBar.frame = self.customTabBar.bounds
        self.customTabBar.addSubview(customTabBar)
    }
}

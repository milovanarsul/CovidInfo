//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var customTabBar: UIView!
    
    var navigationBarDelegate: NavigationBarDelegates!
    var tabBarDelegate: TabBarDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        embedMainPageViewController()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    func setup(){
        embedCustomNavigationBar()
        embedCustomTabBar()
    }
    
    func embedMainPageViewController(){
        let embedMainPageViewController = TabBarEmbedder()
        embedMainPageViewController.embed(withIdentifier: "MainPageViewController", parent: self, container: self.containerView, completion: nil)
    }
    
    func embedCustomNavigationBar(){
        let customNavigationBar = CustomNavigationBar(previousPageTitle: "Acasa", currentPageTitle: "")
        customNavigationBar.frame = self.customNavigationBar.bounds
        navigationBarDelegate = customNavigationBar as! NavigationBarDelegates
        self.customNavigationBar.addSubview(customNavigationBar)
    }
    
    func embedCustomTabBar(){
        let customTabBar = CustomTabBar()
        customTabBar.frame = self.customTabBar.bounds
        customTabBar.tabBarDelegate = self.tabBarDelegate
        self.customTabBar.addSubview(customTabBar)
    }
}

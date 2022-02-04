//
//  HomePageViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    var page: Page = Page(mainPage: .home, childType: .none)
    var navigationBarDelegate: NavigationBarDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarDelegate.setup(page: page)
    }
}

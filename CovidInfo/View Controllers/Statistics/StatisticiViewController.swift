//
//  StatisticiViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class StatisticiViewController: UIViewController {
    
    var page: Page = Page(mainPage: .statistics, childType: .none)
    var navigationBarDelegate: NavigationBarDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarDelegate.setup(page: page)
    }
}

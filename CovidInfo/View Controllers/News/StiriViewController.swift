//
//  StiriViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class StiriViewController: UIViewController {
    
    var page: Page = Page(mainPage: .news, childType: .none)

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.navigationBarDelegate.setup(page: page)
    }
}

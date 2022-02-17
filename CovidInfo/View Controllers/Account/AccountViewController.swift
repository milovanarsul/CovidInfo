//
//  AccountViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 16.02.2022.
//

import UIKit

class AccountViewController: UIViewController {
    
    var page: Page = Page(mainPage: .account, childType: .none)

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.navigationBar.setup(page: page)
    }

}

//
//  DocumenteViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class DocumenteViewController: UIViewController {
    
    var page: Page = Page(mainPage: .documents, childType: .none)

    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.navigationBar.setup(page: page)
    }
}

//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embed()
    }
    
    func embed(){
        let embed = EmbedView()
        embed.headerPageViewController(parent: self, container: headerView)
        headerView.roundCorners([.topLeft], radius: 24)
    }
    
    @IBAction func tap(_ sender: Any) {
        delegates.homePage.goToPage(pageIndex: 2, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
    }
}

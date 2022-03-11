//
//  HomeViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegates.home = self
        embed()
    }
    
    func embed(){
        let embed = EmbedView()
        embed.headerPageViewController(parent: self, container: headerView)
        headerView.bringSubviewToFront(headerPageControl)
        headerView.roundCorners([.topLeft], radius: 24)
    }
}

extension HomeViewController: HomeDelegate{
    func setPageControl(index: Int) {
        headerPageControl.currentPage = index
    }
}

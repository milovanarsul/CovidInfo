//
//  StiriViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 31.01.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    var page: Page = Page(mainPage: .news, childType: .none)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegates.navigationBar.setup(page: page)
    }
}

class NewsView: UIViewController{
    lazy var articlesView: UIView = {
        let view = UIView()
        let embed = EmbedView()
        embed.articleViewController(parent: self, container: view)
        view.cornerRadius = 24
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        self.view.addSubview(articlesView)
        let articlesViewConstraints = Constraints(childView: articlesView, parentView: self.view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 0)
        ])
        articlesViewConstraints.addConstraints()
    }
}

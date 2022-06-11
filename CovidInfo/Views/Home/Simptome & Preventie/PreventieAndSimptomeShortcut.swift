//
//  PreventieAndSimptomeShortcut.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.06.2022.
//

import UIKit

class PreventieAndSimptomeShortcut: UIStackView {
    lazy var preventieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cumSaTeProtejezi")!
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(preventieShortcutTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    lazy var simptomeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ceSimptomeApar")!
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 24
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(simptomeShortcutTapped)))
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        initalize(axis: .horizontal, alignment: .center, distribution: .fillProportionally, spacing: 10)
        addAranagedSubviews(views: [preventieImageView, simptomeImageView])
        layer.cornerRadius = 24
        clipsToBounds = true
    }
    
    @objc func preventieShortcutTapped(){
        delegates.homePage.goToPage(pageIndex: 3, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
    }
    
    @objc func simptomeShortcutTapped(){
        delegates.homePage.goToPage(pageIndex: 2, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
    }
}

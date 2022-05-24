//
//  HomePreventieandSimptomeShortcut.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 18.05.2022.
//

import UIKit

class HomePreventieandSimptomeShortcut: UIStackView {
    
    init(){
        super.init(frame: .zero)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 10)
        addArrangedSubview(horizontalViewShortcut(text: "Simptome", image: "SimptomeHomeShortcut", action: #selector(simptomeShortcutAction)))
        addArrangedSubview(horizontalViewShortcut(text: "Preventie ", image: "PreventieHomeShortcut", action: #selector(preventieShortcutAction)))
    }
    
    func horizontalViewShortcut(text: String, image: String, action: Selector) -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 14
        view.layer.masksToBounds = true
        
        let backgroundImage = UIImageView()
        backgroundImage.image = UIImage(named: image)
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        let label = UILabel()
        label.initialize(text: text, color: .black, font: boldFont(size: 26), alignment: .left, lines: 1)
        view.addSubview(label)
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        labelConstraints.addConstraints()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        
        return view
    }
    
    @objc func simptomeShortcutAction(){
        delegates.homePage.goToPage(pageIndex: 2, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func preventieShortcutAction(){
        delegates.homePage.goToPage(pageIndex: 3, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
        delegates.main.tabAnimation(visibility: .hide)
    }

}

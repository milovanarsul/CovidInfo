//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: UIView {
    
    lazy var childPageButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .black, cornerRadius: 0, font: boldFont(size: 30), backgroundColor: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var parentPageButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .black, cornerRadius: 0, font: boldFont(size: 30), backgroundColor: .white, contentInsets: NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToMainView(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var certifficateButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "", titleColor: .white, cornerRadius: 100, font: boldFont(size: 30), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(), image: UIImage(systemName: "qrcode.viewfinder"))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(certifficateButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    var parentPageButtonLeadingConstraint = NSLayoutConstraint()
    var childPageButtonLeadingConstraint = NSLayoutConstraint()
    var certifficateButtonTrailingConstraint = NSLayoutConstraint()
    
    func setup(){
        addSubviews(views: [childPageButton, parentPageButton, certifficateButton])
        
        parentPageButtonLeadingConstraint = Constraint(childView: parentPageButton, parentView: self, constraintType: .leading, multiplier: 1, constant: 0).setConstraint()
        childPageButtonLeadingConstraint = Constraint(childView: childPageButton, parentView: self, constraintType:.leading, multiplier: 1, constant: -300).setConstraint()
        NSLayoutConstraint.activate([childPageButtonLeadingConstraint, Constraint(childView: childPageButton, parentView: self, constraintType: .vertical, multiplier: 1, constant: 0).setConstraint(), parentPageButtonLeadingConstraint, Constraint(childView: parentPageButton, parentView: self, constraintType: .vertical, multiplier: 1, constant: 0).setConstraint()])
        
        let certifficateButtonConstraints = Constraints(childView: certifficateButton, parentView: self, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .width, multiplier: 1, constant: 40),
            Constraint(constraintType: .height, multiplier: 1, constant: 40),
        ])
        certifficateButtonConstraints.addConstraints()
        certifficateButtonTrailingConstraint = Constraint(childView: certifficateButton, parentView: self, constraintType: .trailing, multiplier: 1, constant: 70).setConstraint()
        NSLayoutConstraint.activate([certifficateButtonTrailingConstraint])
    }
    
    func slideOutParentPageButton(){
        parentPageButtonLeadingConstraint.constant = -parentButtonLeading
        makeChildToParent()
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.parentPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.parentPageButton.isHidden = true
            self.parentPageButtonLeadingConstraint.constant = 0
        })
    }
    
    func makeChildToParent(){
        childPageButtonLeadingConstraint.constant = -parentButtonLeading
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.parentPageButton.isHidden = false
            self.slideInChildPageButton()
        })
    }
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -200
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.childPageButtonLeadingConstraint.constant = 25
        })
    }
    
    func slideInChildPageButton(){
        childPageButton.isHidden = false
        childPageButtonLeadingConstraint.constant = getParentPageButtonWidth() + 0
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.layoutIfNeeded()
        })
    }
    
    private var parentPageTitle: String?
    private var childPageTitle: String?
    private var showChildButton: Bool?
    
    func getParentPageButtonWidth() -> CGFloat{
        return parentPageButton.bounds.width
    }
    
    @objc func goToMainView(_ sender: UIButton) {
        buttonSlider(sliderType: .left)
        delegates.homePage.goToPage(pageIndex:0, direction: .reverse)
        delegates.main.tabBarVisibility(tabBarVisibility: .show)
    }
    
    @objc func certifficateButtonTapped(_ sender: UIButton) {
        defaults.bool(forKey: "certifficateEnrolled") ? delegates.main.certifficateModal() : delegates.main.enrollCertifficate()
    }
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        childPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
        childPageButton.backgroundColor = .clear
    }
    
    func changeParentPageButton(title: String) {
        parentPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
        parentPageButton.backgroundColor = .clear
    }
    
    func currentPageSettings(){
        changeParentPageButton(title: parentPageTitle!)
        
        if childPageTitle != nil{
            changeChildPageButton(title: childPageTitle!)
        }
        
        childPageButton.isHidden = !showChildButton!
    }
}

extension CustomNavigationBar: NavigationBarDelegate{
    func setup(page: Page) {
        parentPageTitle = page.getParentPage()
        
        if page.childType != ChildPages.none {
            childPageTitle = page.getChildPage()
            showChildButton = true
        } else {
            showChildButton = false
        }
        currentPageSettings()
    }
    
    func buttonSlider(sliderType: currentPageButtonSlider) {
        switch sliderType {
        case .left:
            slideOutChildPageButton()
        case .right:
            slideInChildPageButton()
        case .hideParent:
            slideOutParentPageButton()
        }
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButton.isHidden = false
            certifficateButtonTrailingConstraint.constant = -20
        case .hide:
            certifficateButtonTrailingConstraint.constant = 70
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            if visibility == .hide{
                self.certifficateButton.isHidden = true
            }
        })
    }
}

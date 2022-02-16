//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: XIB {
    
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var parentPageButton: UIButton!
    @IBOutlet var childPageButton: UIButton!
    
    @IBOutlet var parentPageButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var childPageButtonLeadingConstraint: NSLayoutConstraint!
    
    func slideOutParentPageButton(){
        parentPageButtonLeadingConstraint.constant = -100
        self.makeChildToParent()
        
        UIView.animate(withDuration: 0.7, animations: {
            self.parentPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.parentPageButton.isHidden = true
            self.parentPageButtonLeadingConstraint.constant = 0
        })
    }
    
    func makeChildToParent(){
        childPageButtonLeadingConstraint.constant = -100
        
        UIView.animate(withDuration: 0.7, animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.parentPageButton.isHidden = false
            self.slideInChildPageButton()
        })
    }
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -100
        
        UIView.animate(withDuration: 0.7, animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.childPageButtonLeadingConstraint.constant = 25
        })
    }
    
    func slideInChildPageButton(){
        childPageButtonLeadingConstraint.constant = getParentPageButtonWidth() + 10
        self.childPageButton.isHidden = false
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        })
    }
    
    private var parentPageTitle: String?
    private var childPageTitle: String?
    private var showChildButton: Bool?
    
    func getParentPageButtonWidth() -> CGFloat{
        return self.parentPageButton.bounds.width
    }
    
    @IBAction func goToMainView(_ sender: Any) {
        buttonSlider(sliderType: .left)
        delegates.home.goToPage(pageIndex:0, direction: .reverse)
        delegates.main.tabBarVisibility(tabBarVisibility: .show)
        delegates.triaj.endTriaj()
    }
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        self.childPageButton.setAttributedTitle(setNSMutableString(title: title, font: UIFont(name: "IBMPlexSans-Bold", size: 30)!, foregroundColor: .black), for: .normal)
        self.childPageButton.backgroundColor = .clear
    }
    
    func changeParentPageButton(title: String) {
        self.parentPageButton.setAttributedTitle(setNSMutableString(title: title, font: UIFont(name: "IBMPlexSans-Bold", size: 30)!, foregroundColor: .black), for: .normal)
        self.parentPageButton.backgroundColor = .clear
    }
    
    func currentPageSettings(){
        changeParentPageButton(title: self.parentPageTitle!)
        
        if self.childPageTitle != nil{
            changeChildPageButton(title: self.childPageTitle!)
        }
        
        self.childPageButton.isHidden = !self.showChildButton!
    }
}

extension CustomNavigationBar: NavigationBarDelegate{
    func setup(page: Page) {
        self.parentPageTitle = page.getParentPage()
        
        if page.childType != ChildPages.none {
            self.childPageTitle = page.getChildPage()
            self.showChildButton = true
        } else {
            self.showChildButton = false
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
}

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
    
    @IBOutlet var childPageButtonLeadingConstraint: NSLayoutConstraint!
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -100
        
        UIView.animate(withDuration: 0.7, delay: 0.0, options: [], animations: {
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
        }, completion: {(finished: Bool) in
           
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
        delegates.homeDelegate.goToPage(pageIndex:0, direction: .reverse)
        delegates.mainDelegate.tabBarVisibility(tabBarVisibility: .show)
    }
    
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        self.childPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
    }
    
    func changeParentPageButton(title: String) {
        self.parentPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
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
        }
    }
}

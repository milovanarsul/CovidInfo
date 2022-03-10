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
        parentPageButtonLeadingConstraint.constant = -parentButtonLeading
        self.makeChildToParent()
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.parentPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.parentPageButton.isHidden = true
            self.parentPageButtonLeadingConstraint.constant = 0
        })
    }
    
    func makeChildToParent(){
        childPageButtonLeadingConstraint.constant = -parentButtonLeading
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
            self.parentPageButton.isHidden = false
            self.slideInChildPageButton()
        })
    }
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -parentButtonLeading
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
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
        
        UIView.animate(withDuration: defaultNavigationAnimation, animations: {
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
    }
    
    @IBOutlet weak var certifficateButon: UIButton!
    @IBOutlet weak var certifficateButtonTrailingConstraint: NSLayoutConstraint!
    
    @IBAction func certifficateButtonTapped(_ sender: Any) {
        //delegates.main.accountModal()
    }
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        self.childPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
        self.childPageButton.backgroundColor = .clear
    }
    
    func changeParentPageButton(title: String) {
        self.parentPageButton.setAttributedTitle(setNSMutableString(title: title, font: boldFont(size: 30), foregroundColor: .black), for: .normal)
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
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            self.certifficateButon.isHidden = false
            self.certifficateButtonTrailingConstraint.constant = 20
        case .hide:
            self.certifficateButtonTrailingConstraint.constant = -70
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButon.layoutIfNeeded()
            self.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            if visibility == .hide{
                self.certifficateButon.isHidden = true
            }
        })
    }
}

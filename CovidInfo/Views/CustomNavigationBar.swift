//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: UIView {
    
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var parentPageButton: UIButton!
    @IBOutlet var childPageButton: UIButton!
    
    private var parentPageTitle: String?
    private var childPageTitle: String?
    private var showChildButton: Bool?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        initWithNib()
    }
    
    fileprivate func initWithNib(){
        Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)
        customNavigationBar.frame = self.bounds
        customNavigationBar.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(customNavigationBar)
    }
    
    func getCurrentPageButtonWidth() -> CGFloat{
        return self.childPageButton.bounds.width
    }
    
    @IBOutlet var childPageButtonLeadingConstraint: NSLayoutConstraint!
    
    func slideOutChildPageButton(){
        childPageButtonLeadingConstraint.constant = -getCurrentPageButtonWidth() - 10
        
        UIView.animate(withDuration: 0.9, delay: 0.5, options: [], animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.childPageButton.isHidden = true
        })
    }
    
    func slideInChildPageButton(){
        self.childPageButton.isHidden = false
        childPageButtonLeadingConstraint.constant = getCurrentPageButtonWidth() + 10
        
        UIView.animate(withDuration: 0.9, delay: 0.5, options: [], animations: {
            self.childPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
        })
    }
}

extension CustomNavigationBar{
    
    func changeChildPageButton(title: String) {
        self.childPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
    }
    
    func changeParentPageButton(title: String) {
        self.parentPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
    }
    
    func buttonSlider(sliderType: currentPageButtonSlider) {
        switch sliderType {
        case .left:
            slideOutChildPageButton()
        case .right:
            slideInChildPageButton()
        }
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
    
    func test(){
        print("Delegate works!")
    }
    
}

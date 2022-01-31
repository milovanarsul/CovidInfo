//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: UIView {
    
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet var currentPageButton: UIButton!
    @IBOutlet var previousPageButton: UIButton!
    
    private var previousPageTitle: String?
    private var currentPageTitle: String?
    
    convenience init(previousPageTitle: String, currentPageTitle: String){
        self.init()
        
        self.previousPageTitle = previousPageTitle
        self.currentPageTitle = currentPageTitle
    }
    
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
        return self.currentPageButton.bounds.width
    }
    
    @IBOutlet var currentPageButtonLeadingConstraint: NSLayoutConstraint!
    
    func dismissCurrentPageButton(){
        currentPageButtonLeadingConstraint.constant = -getCurrentPageButtonWidth() - 10
        
        UIView.animate(withDuration: 0.9, delay: 0.5, options: [], animations: {
            self.currentPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.currentPageButton.isHidden = true
        })
    }
    
    func enableCurrentPageButton(){
        self.currentPageButton.isHidden = false
        currentPageButtonLeadingConstraint.constant = getCurrentPageButtonWidth() + 10
        
        UIView.animate(withDuration: 0.9, delay: 0.5, options: [], animations: {
            self.currentPageButton.layoutIfNeeded()
            self.customNavigationBar.layoutIfNeeded()
        }, completion: {(finished: Bool) in
        })
    }
}

extension CustomNavigationBar: NavigationBarDelegate{
    
    func changeCurrentPageButton(title: String) {
        self.currentPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
    }
    
    func changePreviousPageButton(title: String) {
        self.previousPageButton.setAttributedTitle(changeButtonTitle(title: title, font: "IBMPlexSans-Bold", fontSize: 30, color: UIColor.black), for: .normal)
    }
    
    func buttonSlider(sliderType: currentPageButtonSlider) {
        switch sliderType {
        case .left:
            dismissCurrentPageButton()
        case .right:
            enableCurrentPageButton()
        }
    }
    
    func currentPageSettings(shouldShowCurrentPageButton: Bool){
        changePreviousPageButton(title: self.previousPageTitle!)
        changeCurrentPageButton(title: self.currentPageTitle!)
        self.currentPageButton.isHidden = !shouldShowCurrentPageButton
    }
    
    func test(){
        print("Delegate works!")
    }
    
}

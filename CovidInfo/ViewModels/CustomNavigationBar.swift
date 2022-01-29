//
//  CustomNavigationBar.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 28.01.2022.
//

import UIKit

class CustomNavigationBar: UIView {
    
    @IBOutlet var customNavigationBar: UIView!
    @IBOutlet weak var previousPage: UIButton!
    @IBOutlet weak var currentPage: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    func setPageTitles(previousPageTitle: String, currentPageTitle: String){
        self.previousPage.titleLabel?.text = previousPageTitle
        self.currentPage.titleLabel?.text = currentPageTitle
    }
    
    @IBOutlet weak var currentPageLeadingConstraint: NSLayoutConstraint!
    
    @IBAction func previousPageTapped(_ sender: Any) {
        
        if self.currentPage.isHidden {
            self.currentPageLeadingConstraint.constant = 10
            self.currentPage.isHidden = false
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.currentPage.layoutIfNeeded()
                self.customNavigationBar.layoutIfNeeded()
            }, completion: {(finished: Bool) in
            })
        }else{
            self.currentPageLeadingConstraint.constant = -120
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                self.currentPage.layoutIfNeeded()
                self.customNavigationBar.layoutIfNeeded()
            }, completion: {(finished: Bool) in
                self.currentPage.isHidden = true
            })
        }
    }
    
    @IBAction func currentPageTapped(_ sender: Any) {
    }
    
    @IBAction func accountButtonTapped(_ sender: Any) {
        
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed("CustomNavigationBar", owner: self, options: nil)
        customNavigationBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(customNavigationBar)
        setup()
    }
    
    override func awakeFromNib() {
        initWithNib()
        self.previousPage.titleLabel?.text = "Acasa"
        self.currentPage.titleLabel?.text = "Test"
    }
    
    private func setup(){
        NSLayoutConstraint.activate(
            [
                customNavigationBar.topAnchor.constraint(equalTo: topAnchor),
                customNavigationBar.leadingAnchor.constraint(equalTo: leadingAnchor),
                customNavigationBar.bottomAnchor.constraint(equalTo: bottomAnchor),
                customNavigationBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            ]
        )
    }
    
}

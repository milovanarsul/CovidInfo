//
//  TriajActions.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class TriajActions: XIB {
    @IBOutlet var fullButton: UIButton!
    @IBOutlet var formButton: UIButton!
    @IBOutlet var buttonStack: UIStackView!
    
    convenience init(actionType: TriajAction, actionTitle: Any!, actionForegorund: UIColor? = nil, actionColour: UIColor? = nil) {
        self.init()
        
        self.backgroundColor = .black
        
        switch actionType {
        case .button:
            mainButton(actionTitle: actionTitle as! String, actionForeground: actionForegorund!, actionColor: actionColour!)
        case .buttonForm:
            formButton(actionTitle: actionTitle as! String)
        case .buttonStack:
            self.buttonStack.isHidden = false
            self.buttonStack.setShadow()
        case .none:
            ()
        }
    }
    
    func mainButton(actionTitle: String, actionForeground:UIColor, actionColor: UIColor){
        self.fullButton.isHidden = false
        self.fullButton.setAttributedTitle(setNSMutableString(title: actionTitle, font: UIFont(name: "IBMPlexSans-Bold", size: 14)!, foregroundColor: actionForeground), for: .normal)
        self.fullButton.backgroundColor = actionColor
        self.fullButton.cornerRadius = 8
    }
    
    func formButton(actionTitle: String){
        self.formButton.isHidden = false
        self.formButton.setShadow()
        self.formButton.setAttributedTitle(setNSMutableString(title: actionTitle, font: UIFont(name: "IBMPlexSans-Bold", size: 12)!, foregroundColor: .black), for: .normal)
        self.formButton.backgroundColor = .yellow
    }
    
    @IBAction func fullSimpleButtonTapped(_ sender: Any) {
        let index = delegates.triaj.currentIndex()
        switch index{
        case 6:
            delegates.triaj.goToStart()
        case 7:
            delegates.triaj.goToStart()
        default:
            delegates.triaj.nextPage()
        }
    }
    
    @IBAction func fullOptionButtonTapped(_ sender: Any) {
        delegates.triaj.nextPage()
    }
    
    @IBAction func stackOptionTrueButtonTapped(_ sender: Any) {
        delegates.triaj.nextPage()
    }
    
    @IBAction func stackOptionFalseButtonTapped(_ sender: Any) {
        delegates.triaj.nextPage()
    }
}

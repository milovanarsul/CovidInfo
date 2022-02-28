//
//  TriajActions.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit
import CoreData

class TriajActions: XIB {
    @IBOutlet var fullButton: UIButton!
    @IBOutlet var formButton: UIButton!
    @IBOutlet var buttonStack: UIStackView!
    
    var riskFactor: Double!
    var currentIndex: Int!
    
    convenience init(actionType: TriajAction, actionTitle: Any!, actionForegorund: UIColor? = nil, actionColour: UIColor? = nil, riskFactor: Double? = nil) {
        self.init()
        
        self.currentIndex = delegates.triaj.currentIndex() + 1
        
        if let riskFactor = riskFactor {
            self.riskFactor = riskFactor
        }
        
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
        self.fullButton.setAttributedTitle(setNSMutableString(title: actionTitle, font: boldFont(size: 14), foregroundColor: actionForeground), for: .normal)
        self.fullButton.backgroundColor = actionColor
        self.fullButton.cornerRadius = 8
    }
    
    func formButton(actionTitle: String){
        self.formButton.isHidden = false
        self.formButton.setShadow()
        self.formButton.setAttributedTitle(setNSMutableString(title: actionTitle, font: boldFont(size: 12), foregroundColor: .black), for: .normal)
        self.formButton.backgroundColor = .yellow
    }
    
    func results(){
        if self.currentIndex == 6 {
            if riskPrecentage < 2.5{
                delegates.triaj.nextPage(index: currentIndex)
            } else{
                delegates.triaj.nextPage(index: currentIndex + 1)
            }
        } else{
            delegates.triaj.nextPage(index: currentIndex)
        }
    }
    
    @IBAction func fullSimpleButtonTapped(_ sender: Any) {
        switch self.currentIndex{
        case 7:
            delegates.triaj.goToStart()
        case 8:
            delegates.triaj.goToStart()
        default:
            delegates.triaj.nextPage(index: currentIndex)
        }
    }
    
    @IBAction func fullOptionButtonTapped(_ sender: Any) {
        delegates.triaj.nextPage(index: currentIndex)
        riskPrecentage += riskFactor
    }
    
    @IBAction func stackOptionTrueButtonTapped(_ sender: Any) {
        riskPrecentage += 0.8
        results()
    }
    
    @IBAction func stackOptionFalseButtonTapped(_ sender: Any) {
        riskPrecentage += 0.1
        results()
    }
}

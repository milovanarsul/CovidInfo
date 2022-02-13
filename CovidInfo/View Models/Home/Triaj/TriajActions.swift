//
//  TriajActions.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class TriajActions: XIB {
    @IBOutlet var button: UIButton!
    @IBOutlet var formButton: UIButton!
    @IBOutlet var buttonStack: UIStackView!
    
    convenience init(subviewType: TriajType? = nil , actionType: TriajAction, actionTitle: Any!, actionForegorund: UIColor? = nil, actionColour: UIColor? = nil) {
        self.init()
        
        switch actionType {
        case .button:
            mainButton(actionTitle: actionTitle as! String, actionForeground: actionForegorund!, actionColor: actionColour!)
        case .buttonForm:
            formButton(actionTitle: actionTitle as! String)
        case .buttonStack:
            self.buttonStack.isHidden = false
        case .none:
            print("no action")
        }
        
        if subviewType != nil {
            formButton(actionTitle: actionTitle as! String)
            print(self.formButton.isHidden)
        }
    }
    
    func mainButton(actionTitle: String, actionForeground:UIColor, actionColor: UIColor){
        self.button.isHidden = false
        self.button.setAttributedTitle(initalizeButton(title: actionTitle, font: UIFont(name: "IBMPlexSans-Bold", size: 14)!, foregroundColor: actionForeground, backgroundColor: actionColor), for: .normal)
        
    }
    
    func formButton(actionTitle: String){
        self.formButton.isHidden = false
        self.button.setAttributedTitle(initalizeButton(title: actionTitle, font: UIFont(name: "IBMPlexSans-Bold", size: 14)!, foregroundColor: .black, backgroundColor: .white), for: .normal)
    }
    
    @IBAction func fullSimpleButtonTapped(_ sender: Any) {
        delegates.triaj.nextPage()
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

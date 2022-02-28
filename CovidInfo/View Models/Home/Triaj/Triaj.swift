//
//  Triaj.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class Triaj: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var containerView: UIView!
    @IBOutlet var actionsView: UIView!
    
    var data: TriajData!
    
    init(data: TriajData){
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.triajSub = self
        
        self.imageView.image = UIImage(named: data.image)
        self.label.attributedText = setNSMutableString(title: data.title, font: boldFont(size: data.actionSize), foregroundColor: data.titleColor!)
        
        self.containerView.addSubView(parentView: self.containerView, childView: TriajSubview(type: data.subViewType, subview: data.subView!))
        self.actionsView.addSubView(parentView: self.actionsView, childView: TriajActions(actionType: data.actionType, actionTitle: data.actionTitle, actionForegorund: data.actionForeground, actionColour: data.actionColour))
        self.actionsView.backgroundColor = .black
    }
    
    @IBOutlet var containerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var containerViewHeightConstraint: NSLayoutConstraint!
}

extension Triaj: TriajSubDelegate{
    func resizeContainerView() {
        self.containerViewWidthConstraint.changeMultiplier(multiplier: 0.95)
        self.containerViewHeightConstraint.changeMultiplier(multiplier: 0.27)
    }
    
    func resetContainerView(){
        self.containerViewWidthConstraint.changeMultiplier(multiplier: 0.647343)
        self.containerViewHeightConstraint.changeMultiplier(multiplier: 0.3)
    }
}

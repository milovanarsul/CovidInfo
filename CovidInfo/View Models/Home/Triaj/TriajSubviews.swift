//
//  TriajSubviewOne.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class TriajSubview: UIView{
    convenience init(type: TriajType, subview: Any) {
        self.init()
        initSubView(type: type, subview: subview)
    }
    
    func initSubView(type: TriajType, subview: Any){
        switch type {
        case .intro:
            self.addSubView(parentView: self, childView: TriajIntroSubview(subview: subview))
        case .text:
            self.addSubView(parentView: self, childView: TriajTextSubview(subview: subview))
        case .form:
            self.addSubView(parentView: self, childView: TriajFormSubview(subview: subview))
        case .finish:
            self.addSubView(parentView: self, childView: subview as! UIView)
        }
    }
}

class TriajIntroSubview: UIView {
    
    convenience init(subview: Any) {
        self.init()
        cells(subview: subview as! [(String,String)])
    }
    
    func cells(subview: [(String,String)]){
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 10)
        
        for data in subview{
            let element = cell(image: data.0, labelText: data.1)
            stackView.addArrangedSubview(element)
        }
        
        self.addSubView(parentView: self, childView: stackView)
        
        let stackViewConstraints = Constraints(childView: stackView, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: -20),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -20),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        stackViewConstraints.addConstraints()
    }
    
    func cell(image: String, labelText: String) -> UIView{
        let view = UIView()
        let imageView = UIImageView()
        let label = UILabel()
        
        imageView.image = UIImage(systemName: image)
        imageView.tintColor = .black
        label.initialize(text: labelText, color: .black, font: UIFont(name: "IBMPlexSans-Bold", size: 10)!, alignment: .left, lines: 0)
        
        view.addSubview(imageView)
        view.addSubview(label)
        
        let imageViewConstraints = Constraints(childView: imageView, parentView: view, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 20),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.4, constant: 0)
        ])
        imageViewConstraints.addConstraints()
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 20)
        ])
        labelConstraints.addConstraints()
        
        NSLayoutConstraint.activate([NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: imageView, attribute: .trailing, multiplier: 1, constant: 20)])
        
        return view
    }
}

class TriajTextSubview: UIView{
    
    convenience init(subview: Any) {
        self.init()
        text(subview: subview as! String)
    }
    
    func text(subview: String){
        let label = UILabel()
        
        var alignment: NSTextAlignment!
        var textSize: CGFloat!
        switch delegates.triaj.currentIndex(){
        case 7:
            textSize = 16
            alignment = .center
        default:
            textSize = 14
            alignment = .left
        }
        
        label.initialize(text: subview, color: .black, font: UIFont(name: "IBMPlexSans-Bold", size: textSize)!, alignment: alignment, lines: 0)
        self.addSubView(parentView: self, childView: label)
        
        let labelConstraints = Constraints(childView: label, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        labelConstraints.addConstraints()
    }
}

class TriajFormSubview: UIView{
    convenience init(subview: Any) {
        self.init()
        form(subview: subview as! [String])
    }
    
    func form(subview: [String]){
        let verticalStackView = UIStackView()
        verticalStackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 5)
        
        for option in subview{
            let action = TriajActions(actionType: .buttonForm, actionTitle: option)
            verticalStackView.addArrangedSubview(action)
        }
        
        self.addSubView(parentView: self, childView: verticalStackView)
        
        let verticalStackViewConstraint = Constraints(childView: verticalStackView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.33 * CGFloat(subview.count), constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0)
        ])
        verticalStackViewConstraint.addConstraints()
    }
}

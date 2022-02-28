//
//  CertifficateViews.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.02.2022.
//

import UIKit

class CertifficateView: UIView{
    var parentView: UIView!
    
    func setup(certifficateEnrollment: CertifficateEnrollment){
        switch certifficateEnrollment {
        case .enrolled:
            let view = CertifficateEnrolled()
            view.setup()
            self.addSubview(view)
        case .notEnrolled:
            let view = CertifficateNotEnrolled()
            view.setup()
            self.addSubview(view)
        }
    }
    
    func constraints(){
        let constraints = Constraints(childView: self, parentView: self.parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0)
        ])
        constraints.addConstraints()
    }
}

class CertifficateNotEnrolled: UIView {
    private var label = UILabel()
    private var button = UIButton()
    
    func setup(){
        delegates.customPresentation.setPresentationHeight(presentationHeight: .small)
        self.label.initialize(text: "Nu ai un certificat inrolat!", color: .black, font: boldFont(size: 18), alignment: .center, lines: 0)
        self.button.setTitle("Inroleaza certificat", for: .normal)
        self.button.setTitleColor(.white, for: .normal)
        self.button.cornerRadius = 18
        self.button.titleLabel?.font = boldFont(size: 14)
        self.button.backgroundColor = signatureBlueDark
        
        self.button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        self.addSubview(label)
        self.addSubview(button)
        contentConstraints()
    }
    
    @objc func buttonPressed(){
        delegates.main.presentEnrollCertifficate()
    }
    
    func contentConstraints(){
        let labelConstraints = Constraints(childView: self.label, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 50)
        ])
        labelConstraints.addConstraints()
        
        let buttonConstraints = Constraints(childView: self.button, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.2, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.4, constant: 0)
        ])
        buttonConstraints.addConstraints()
        
        NSLayoutConstraint.activate([NSLayoutConstraint(item: self.button, attribute: .top, relatedBy: .equal, toItem: self.label, attribute: .bottom, multiplier: 1, constant: 20)])
    }
}

class CertifficateEnrolled: UIView{
    private var imageView = UIImageView()
    
    func setup(){
        delegates.customPresentation.setPresentationHeight(presentationHeight: .medium)
        self.imageView.image = UIImage(named: "QR")
        self.imageView.contentMode = .scaleAspectFit
        self.addSubview(self.imageView)
        
        let constraints = Constraints(childView: imageView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0)
        ])
        constraints.addConstraints()
    }
}

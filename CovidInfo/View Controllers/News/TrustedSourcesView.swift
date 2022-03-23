//
//  TrustedSourcesView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.03.2022.
//

import Foundation
import UIKit
import SafariServices

class TrustedSources: UIStackView{
    
    func setup(){
        self.backgroundColor = .clear
        self.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 0)
        
        for trustedSource in trustedSourcesData{
            self.addArrangedSubview(TrustedSource(sourceLogo: trustedSource.image, sourceName: trustedSource.text, url: trustedSource.url))
        }
    }
}

class TrustedSource: UIView{
    var imageView = UIImageView()
    var label = UILabel()
    
    var sourceLogo: String!
    var sourceName: String!
    var url: String!
    
    convenience init(sourceLogo: String, sourceName: String, url: String) {
        self.init()
        self.sourceLogo = sourceLogo
        self.sourceName = sourceName
        self.url = url
        
        setup()
    }
    
    func setup(){
        self.backgroundColor = .clear
        imageView.image = UIImage(named: sourceLogo)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        label.initialize(text: sourceName, color: .black, font: boldFont(size: 14), alignment: .center, lines: 0)
        self.addSubview(label)
        
        constraints()
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    
    func constraints(){
        let logoConstraints = Constraints(childView: imageView, parentView: self, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.6, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.6, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        logoConstraints.addConstraints()
        
        let nameConstraints = Constraints(childView: label, parentView: self, constraints: [Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)])
        nameConstraints.addConstraints()
        NSLayoutConstraint.activate([NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: imageView, attribute: .bottom, multiplier: 1, constant: 10)])
        
        let viewConstraints = Constraints(childView: self, parentView: self, constraints: [
            Constraint(constraintType: .width, multiplier: 1, constant: 100),
        ])
        viewConstraints.addConstraints()
    }
    
    @objc func tapGesture(){
        showWebPage(url: url, viewController: delegates.news as! UIViewController)
    }
}

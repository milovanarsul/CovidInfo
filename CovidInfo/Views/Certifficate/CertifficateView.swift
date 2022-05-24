//
//  CertifficateViews.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.03.2022.
//

import Foundation
import UIKit

class CertifficateView: UIView{
    private var imageView = UIImageView()
    
    func setup(){
        self.backgroundColor = .white
        localStorageManager.display(key: "QRCode", imageView: imageView)
        imageView.contentMode = .scaleAspectFit
        self.addSubview(imageView)
        
        let imageViewConstraints = Constraints(childView: imageView, parentView: self,  constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0)
        ])
        imageViewConstraints.addConstraints()
    }
}

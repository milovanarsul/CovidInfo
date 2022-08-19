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
    
    lazy var simulator: UIView = {
        lazy var warning: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "exclamationmark.triangle")
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .red
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        lazy var text: UILabel = {
            let label = UILabel()
            label.initialize(text: "Înrolarea certificatului este disponibilă\n doar pe un dispozitiv fizic", color: .black, font: boldFont(size: 14), alignment: .center, lines: 0)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let view = UIView()
        view.addSubviews(views: [warning, text])
        view.backgroundColor = .clear
        
        let warningConstraints = Constraints(childView: warning, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.2, constant: 0)
        ])
        warningConstraints.addConstraints()
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.topAnchor.constraint(equalTo: warning.bottomAnchor, constant: 20)
        ])
        
        return view
    }()
    
    func setup(){
        self.backgroundColor = .white
        
        #if targetEnvironment(simulator)
            addSubview(simulator)
            
        let simulatorConstraints = Constraints(childView: simulator, parentView: self, constraints: [
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 1, constant: 0),
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        simulatorConstraints.addConstraints()
        
        #else
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
        #endif
    }
}

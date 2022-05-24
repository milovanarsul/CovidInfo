//
//  Triaj.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 13.02.2022.
//

import UIKit

class TriajViewController: UIViewController {
    var data: TriajData!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: data.image)!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.initialize(text: data.title, color: data.titleColor!, font: boldFont(size: data.actionSize), alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var actionsView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(data: TriajData){
        self.data = data
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.triajSub = self
    }
    
    var containerViewWidthConstraint: NSLayoutConstraint?
    var containerViewHeightConstraint: NSLayoutConstraint?
    
    func setup(){
        view.addSubviews(views: [imageView, label, containerView, actionsView])
        
        let imageViewConstraints = Constraints(childView: imageView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 30),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.35, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        imageViewConstraints.addConstraints()
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        
        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30).isActive = true
        containerViewWidthConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0.647343)
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0.3)
        NSLayoutConstraint.activate([containerViewWidthConstraint!, containerViewHeightConstraint!])
        
        let actionsViewConstraints = Constraints(childView: actionsView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 50),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.08, constant: 0)
        ])
        actionsViewConstraints.addConstraints()
        actionsView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
    }
}

extension TriajViewController: TriajSubDelegate{
    func resizeContainerView() {
        self.containerViewWidthConstraint!.changeMultiplier(multiplier: 0.95)
        self.containerViewHeightConstraint!.changeMultiplier(multiplier: 0.27)
    }
    
    func resetContainerView(){
        self.containerViewWidthConstraint!.changeMultiplier(multiplier: 0.647343)
        self.containerViewHeightConstraint!.changeMultiplier(multiplier: 0.3)
    }
}

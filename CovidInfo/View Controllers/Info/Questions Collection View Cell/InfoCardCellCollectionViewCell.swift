//
//  InfoCardCellCollectionViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.05.2022.
//

import UIKit

class InfoCardCellCollectionViewCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var frontLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }
    
    func setup(){
        self.addSubview(containerView)
        defaultConstraints(childView: containerView, parentView: self)
    
        containerView.addSubview(frontLabel)
        let frontLabelConstraints = Constraints(childView: frontLabel, parentView: containerView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        frontLabelConstraints.addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        frontLabel.text = nil
    }
}

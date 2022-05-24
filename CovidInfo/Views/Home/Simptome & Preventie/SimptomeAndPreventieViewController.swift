//
//  SimptomeAndRenameViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.05.2022.
//

import UIKit

class SimptomeAndPreventieViewController: UIViewController {
    
    var staticType: StaticType
    
    lazy var topView: UIView = {
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "info.circle")!
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = .black
            return imageView
        }()
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Pentru a afla mai multe informatii accesati cetrebuiesafac.ro", color: .black, font: boldFont(size: 14), alignment: .left, lines: 0)
            return label
        }()
        
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubviews(views: [imageView, label])
        
        let imageViewConstraints = Constraints(childView: imageView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 10),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 20),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        imageViewConstraints.addConstraints()
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -10),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 5)
        ])
        labelConstraints.addConstraints()
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        
        return view
    }()
    
    lazy var collectionView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    init(staticType: StaticType){
        self.staticType = staticType
        super.init(nibName: nil, bundle: nil)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedCollectionView()

    }
    
    func setup(){
        view.addSubviews(views: [topView, collectionView])
        
        let topViewConstraints = Constraints(childView: topView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 24),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .height, multiplier: 1, constant: 60)
        ])
        topViewConstraints.addConstraints()
        
        let collectionViewConstraints = Constraints(childView: collectionView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0),
        ])
        collectionViewConstraints.addConstraints()
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
    }
    
    func embedCollectionView(){
        embed.simptomeAndPreventieViewController(parent: self, container: self.collectionView)
    }
}

extension SimptomeAndPreventieViewController: StaticDelegate {
    func getCards() -> ([SimptomeAndPreventieData], UIColor, Int) {
        switch self.staticType{
        case .preventie:
            return (preventie.cards, preventie.borderColor, preventie.cards.count)
        case .simptome:
            return (simptome.cards, simptome.borderColor, simptome.cards.count)

        }
    }
}

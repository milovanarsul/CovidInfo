//
//  InfoViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 25.04.2022.
//

import UIKit
import Firebase
import BetterSegmentedControl

class InfoViewController: UIViewController {
    
    var infoCardsDataArray: [InfoCardsData]?
    
    lazy var categories: BetterSegmentedControl = {
        let regularFont = UIFont(name: "IBMPLexSans-Regular", size: 14)!
        let categories = BetterSegmentedControl(frame: .zero, segments: LabelSegment.segments(withTitles: ["Intrebari frecvente", "Vaccinare", "Variante"], normalFont: regularFont, normalTextColor: .black, selectedFont: regularFont ,selectedTextColor: .white), options: [.backgroundColor(.white), .indicatorViewBackgroundColor(.black), .cornerRadius(16), .animationSpringDamping(1.0)])
        categories.addTarget(self, action: #selector(categoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var categoriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(categories)
        let categoriesConstraints = Constraints(childView: categories, parentView: scrollView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 15),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 15),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        categoriesConstraints.addConstraints()
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var collectionViewContainer: UIView = {
        let view = UIView()
        embed.infoCardsCollectionViewController(parent: self, container: view)
        return view
    }()
    
    lazy var variantsViewContainer: UIView = {
        let view = UIView()
        embed.variantsViewController(parent: self, container: view)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.info = self
        setup()
    }
    
    func setup(){
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        
        view.addSubviews(views: [categoriesScrollView, collectionViewContainer])
        
        let categoriesScrollViewConstraints = Constraints(childView: categoriesScrollView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 30),
            Constraint(constraintType: .top, multiplier: 1, constant: 15)
        ])
        categoriesScrollViewConstraints.addConstraints()
        
        let collectionViewContainerConstraints = Constraints(childView: collectionViewContainer, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        collectionViewContainerConstraints.addConstraints()
        NSLayoutConstraint.activate([collectionViewContainer.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 15)])
    }
    
    func setupVariantsViewContainer(){
        view.addSubview(variantsViewContainer)
        
        let variantsViewContainerConstraints = Constraints(childView: variantsViewContainer, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        variantsViewContainerConstraints.addConstraints()
        NSLayoutConstraint.activate([variantsViewContainer.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 10)])
    }
    
    @objc func categoriesTapped(_ sender: BetterSegmentedControl){
        switch sender.index {
        case 0:
            collectionViewContainer.isHidden = false
            variantsViewContainer.isHidden = true
            delegates.infoCardsCollectionView.pullInfoCardsData(type: .intrebariFrecvente)
        case 1:
            collectionViewContainer.isHidden = false
            variantsViewContainer.isHidden = true
            delegates.infoCardsCollectionView.pullInfoCardsData(type: .vaccinare)
        case 2:
            collectionViewContainer.isHidden = true
            variantsViewContainer.isHidden = false
            setupVariantsViewContainer()
        default: ()
        }
    }
}

extension InfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = 0.0
    }
}

extension InfoViewController: InfoViewControllerDelegate{
    func getCardsViewController() -> UIViewController{
        return self.children[1]
    }
}



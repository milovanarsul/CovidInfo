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
        let categories = BetterSegmentedControl(frame: .zero,
                                                segments: LabelSegment.segments(withTitles: ["Calatorie","Intrebari frecvente", "Vaccinare", "Variante"], normalFont: boldFont(size: 14), normalTextColor: .black, selectedFont: boldFont(size: 14) ,selectedTextColor: .white),
                                                options: [.backgroundColor(.white), .indicatorViewBackgroundColor(signatureLightBlue), .cornerRadius(16), .animationSpringDamping(1.0),])
        categories.segmentPadding = 2.0
        categories.panningDisabled = true
        categories.addTarget(self, action: #selector(categoriesTapped(_:)), for: .valueChanged)
        return categories
    }()
    
    lazy var categoriesScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(categories)
        let categoriesConstraints = Constraints(childView: categories, parentView: scrollView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 15),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -15),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        categoriesConstraints.addConstraints()
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var infoPageViewController: UIView = {
        let view = UIView()
        embed.infoPageViewController(parent: self, container: view)
        return view
    }()
    
    var currentIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegates.info = self
        setup()
    }
    
    func setup(){
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        
        view.addSubviews(views: [categoriesScrollView, infoPageViewController])
                
        let categoriesScrollViewConstraints = Constraints(childView: categoriesScrollView, parentView: view, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 30),
            Constraint(constraintType: .top, multiplier: 1, constant: 15)
        ])
        categoriesScrollViewConstraints.addConstraints()
        
        let infoPageViewControllerConstraints = Constraints(childView: infoPageViewController, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        infoPageViewControllerConstraints.addConstraints()
        infoPageViewController.topAnchor.constraint(equalTo: categoriesScrollView.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func categoriesTapped(_ sender: BetterSegmentedControl){
        var scrollDirection: UIPageViewController.NavigationDirection?
        
        if sender.index < currentIndex {
            scrollDirection = .reverse
        } else {
            scrollDirection = .forward
        }
        
        switch sender.index {
        case 0:
            delegates.infoPage.goToPage(pageIndex: 0, direction: scrollDirection!)
        case 1:
            delegates.infoPage.goToPage(pageIndex: 1, direction: scrollDirection!)
        case 2:
            delegates.infoPage.goToPage(pageIndex: 2, direction: scrollDirection!)
        case 3:
            delegates.infoPage.goToPage(pageIndex: 3, direction: scrollDirection!)
        default: ()
        }
        
        currentIndex = sender.index
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



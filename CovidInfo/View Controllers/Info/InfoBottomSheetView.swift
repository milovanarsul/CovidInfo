//
//  InfoBottomSheetView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 05.05.2022.
//

import Foundation
import UIKit

class InfoBottomSheetView: UIViewController {
    var titleText: String?
    var contentsText: String?
    
    lazy var sheetTile: UILabel = {
        let label = UILabel()
        label.initialize(text: titleText!, color: .black, font: boldFont(size: 20), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var sheetContents: UILabel = {
        let label = UILabel()
        label.initialize(text: contentsText!, color: .black, font: UIFont(name: "IBMPlexSans-Regular", size: 14)!, alignment: .left, lines: 0)
        return label
    }()
    
    lazy var slideIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        let dragGesture = UIPanGestureRecognizer(target: self, action: #selector(slideGestureRecognizer))
        view.addGestureRecognizer(dragGesture)
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = view.frame.origin
        }
    }
    
    func setup(){
        view.backgroundColor = .white
        view.layer.cornerRadius = 24
        view.layer.masksToBounds = true
        
        view.addSubviews(views: [slideIndicator, sheetTile, sheetContents])
        
        let slideIndicatorConstraints = Constraints(childView: slideIndicator, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .width, multiplier: 1, constant: 60),
            Constraint(constraintType: .height, multiplier: 1, constant: 4),
            Constraint(constraintType: .top, multiplier: 1, constant: 20)
        ])
        slideIndicatorConstraints.addConstraints()
        
        let sheetTitleConstraints = Constraints(childView: sheetTile, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
        ])
        sheetTitleConstraints.addConstraints()
        NSLayoutConstraint.activate([sheetTile.topAnchor.constraint(equalTo: slideIndicator.bottomAnchor, constant: 20)])
        
        let sheetContentsConstraints = Constraints(childView: sheetContents, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 20)
        ])
        sheetContentsConstraints.addConstraints()
        NSLayoutConstraint.activate([sheetContents.topAnchor.constraint(equalTo: sheetTile.bottomAnchor, constant: 10)])
    }
    
    @objc func slideGestureRecognizer(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else {return}
        view.frame.origin = CGPoint(x: 0, y: pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3){
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
    
    init(title: String, contents: String){
        self.titleText = title
        self.contentsText = contents
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
}

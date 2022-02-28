//
//  SlideInView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.02.2022.
//

import UIKit

class SlideInView: UIViewController{
    
    private var hasSetPointOrgin: Bool = false
    private var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer))
        self.view.addGestureRecognizer(panGesture)
        
        dismissPill()
        certifficateView()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrgin {
            hasSetPointOrgin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    @objc func panGestureRecognizer(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: view)
        guard translation.y >= 0 else {return}
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
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
    
    func dismissPill(){
        let dismissPill = UIView()
        dismissPill.backgroundColor = .gray
        dismissPill.cornerRadius = 4
        
        self.view.addSubview(dismissPill)
        
        let constraints = Constraints(childView: dismissPill, parentView: self.view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 7)
        ])
        constraints.addConstraints()
    }
    
    func certifficateView(){
        self.view.backgroundColor = .white
        
        switch isCertifficateEnrolled{
        case true:
            let view = CertifficateEnrolled()

            view.setup()
            self.view.addSubview(view)
            certifficateConstraints(childView: view, parentView: self.view)
        case false:
            let view = CertifficateNotEnrolled()
            view.setup()
            self.view.addSubview(view)
            certifficateConstraints(childView: view, parentView: self.view)
        }
    }
}

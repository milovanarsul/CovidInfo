//
//  SlideInView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.02.2022.
//

import UIKit

class SlideInView: UIViewController {
    private var hasSetPointOrgin: Bool = false
    private var pointOrigin: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizer))
        self.view.addGestureRecognizer(panGesture)
        
        addSampleView()
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
    
    func addSampleView(){
        self.view.backgroundColor = .white
        
        let label = UILabel()
        label.initialize(text: "Test", color: .black, font: fontB30, alignment: .center, lines: 0)
        
        self.view.addSubview(label)
        let labelConstraints = Constraints(childView: label, parentView: self.view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.2, constant: 0)
        ])
        labelConstraints.addConstraints()
    }
    
}

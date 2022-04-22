//
//  FirebaseTest.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 22.04.2022.
//

import Foundation
import UIKit
import Firebase

class FirebaseTest: UIViewController{
    
    private let database = Database.database().reference()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.initialize(title: "Test", titleColor: .black, cornerRadius: 2, font: boldFont(size: 12), backgroundColor: .blue)
        button.addTarget(self, action: #selector(test), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(button)
        xyConstraints(childView: button, parentView: view)
    }
    
    @objc func test(){
        print("hi")
        database.child("something").setValue("test")
    }
}

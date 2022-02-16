//
//  PreventieAndSimptomeShortcut.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 15.02.2022.
//

import UIKit

class PreventieAndSimptomeShortcut: XIB {
    @IBOutlet var preventieShortcut: UIView!
    @IBOutlet var simptomeShortcut: UIView!
    
    override func initUI() {
        let preventieTap = UITapGestureRecognizer(target: self, action: #selector(self.preventieShortcutTapped))
        self.preventieShortcut.addGestureRecognizer(preventieTap)
        
        let simptomeTap = UITapGestureRecognizer(target: self, action: #selector(self.simptomeShortcutTapped))
        self.simptomeShortcut.addGestureRecognizer(simptomeTap)
    }
    
    @objc func preventieShortcutTapped(){
        delegates.home.goToPage(pageIndex: 3, direction: .forward)
        delegates.home.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
    }
    
    @objc func simptomeShortcutTapped(){
        delegates.home.goToPage(pageIndex: 2, direction: .forward)
        delegates.home.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
    }
}

//
//  XIB.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class XIB: UIView{
    func initUI() {}

    private func xibSetup() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        initUI()
    }

    private func loadViewFromNib() -> UIView {
        let thisName = String(describing: type(of: self))
        let view = Bundle(for: self.classForCoder).loadNibNamed(thisName, owner: self, options: nil)?.first as! UIView
        return view
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

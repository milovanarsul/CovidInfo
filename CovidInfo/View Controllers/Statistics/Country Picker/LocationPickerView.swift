//
//  LocationPickerView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.05.2022.
//

import UIKit

class LocationPickerView: UIView {
    
    var location: String?
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        let text = "Locație automată"
        label.initialize(text: text, color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.onTintColor = signatureDarkBlue
        locationSwitch.preferredStyle = .sliding
        locationSwitch.isOn = defaults.bool(forKey: "useAutomaticLocation")
        locationSwitch.addTarget(self, action: #selector(switchAction), for: .valueChanged)
        return locationSwitch
    }()
    
    init(location: String){
        self.location = location
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubviews(views: [mainLabel, locationSwitch])
        
        let locationStackViewConstraints = Constraints(childView: mainLabel, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        locationStackViewConstraints.addConstraints()
        
        let locationSwitchConstraints = Constraints(childView: locationSwitch, parentView: self, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0)
        ])
        locationSwitchConstraints.addConstraints()
    }
    
    @objc func switchAction(sender: UISwitch!){
        if sender.isOn == false{
            delegates.main.animateContentView(size: 650)
            delegates.main.contentViewVisibility(visibility: .hide)
        } else {
            if defaults.bool(forKey: "locationPermissionDenied"){
                delegates.main.locationDenied()
                locationSwitch.isOn = false
            } else {
                DispatchQueue.main.async {
                    defaults.set(true, forKey: "useAutomaticLocation")
                    delegates.main.refreshData()
                }
            }
        }
    }
}

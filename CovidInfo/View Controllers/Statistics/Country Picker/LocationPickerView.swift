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
        let text = defaults.bool(forKey: "automaticLocation") ? "Locatie automata" : "Locatie manuala"
        label.initialize(text: text, color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
        return label
    }()
    
    lazy var desriptionLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: location!, color: .gray, font: UIFont(name: "IBMPlexSans-Regular", size: 14)!, alignment: .left, lines: 0)
        return label
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 5)
        stackView.addArrangedSubview(mainLabel)
        defaults.bool(forKey: "automaticLocation") ? stackView.addArrangedSubview(desriptionLabel) : ()
        return stackView
    }()
    
    lazy var locationSwitch: UISwitch = {
        let locationSwitch = UISwitch()
        locationSwitch.onTintColor = signatureDarkBlue
        locationSwitch.preferredStyle = .sliding
        locationSwitch.isOn = defaults.bool(forKey: "automaticLocation")
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
        addSubviews(views: [locationStackView, locationSwitch])
        
        let locationStackViewConstraints = Constraints(childView: locationStackView, parentView: self, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.7, constant: 0)
        ])
        locationStackViewConstraints.addConstraints()
        
        let locationSwitchConstraints = Constraints(childView: locationSwitch, parentView: self, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -24),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        locationSwitchConstraints.addConstraints()
    }
    
    @objc func switchAction(sender: UISwitch!){
        if sender.isOn == false{
            delegates.main.animateContentView(size: 650)
            self.desriptionLabel.isHidden = true
            //delegates.statistics.contentViewVisibility(visibility: true)
            defaults.set(sender.isOn, forKey: "automaticLocation")
            delegates.info.viewsVisibility(visibility: true)
        } else {
            delegates.main.animateContentView(size: 80)
            self.desriptionLabel.isHidden = false
            delegates.info.viewsVisibility(visibility: false)
            //delegates.statistics.contentViewVisibility(visibility: false)
            defaults.set(sender.isOn, forKey: "automaticLocation")
            //delegates.statistics.setupCountry()
        }
    }
}

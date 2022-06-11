//
//  OnboardingDownloadData.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 07.06.2022.
//

import UIKit

class OnboardingDownloadData: UIView {

    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.initialize(text: "Pregătim datele pentru tine\n Durează câteva momente...", color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(){
        super.init(frame: .zero)
        delegates.onboardingDownload = self
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        addSubviews(views: [activityIndicator, label])
        
        xyConstraints(childView: activityIndicator, parentView: self)
        
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 30).isActive = true
        
        activityIndicator.startAnimating()
    }
}

func goToMain(finsihed: Bool){
    if finsihed{
        DispatchQueue.main.async {
            delegates.onboarding.goToMain()
        }
    }
}

extension OnboardingDownloadData: OnboardingDownload{
    func downloadData(dataRequest: DataRequest){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            switch dataRequest {
            case .all:
                DataManager.loadAllData(){finished in
                    goToMain(finsihed: finished)
                }
            case .refresh:
                DataManager.loadAllData(){ finished in
                    goToMain(finsihed: finished)
                }
            case .load:
                DataManager.loadData(){ finished in
                    goToMain(finsihed: finished)
                }
            }
        }
    }
}

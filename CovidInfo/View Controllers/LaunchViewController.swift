//
//  LaunchViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import CoreData

private var onboardingCompleted: Bool = false

class LaunchViewController: UIViewController {
    
    var currentData: [CurrentData]?
    var historicData: [HistoricData]?
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstOnboarding")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var launchView: UIView = {
        let view = UIView()
        view.dropShadow = true
        view.cornerRadius = 24
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var onboardingView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if targetEnvironment(simulator)
            defaults.set(true, forKey: "certifficateEnrolled")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        delegates.launch = self
        fetchStatistics()
        setup()
        isFirstLaunch()
        showOnboarding ? startOnboarding() : goTomain()
        onboardingCompleted ? skipOnboarding() : ()
    }
    
    func fetchStatistics(){
        let currentDataRequest = CurrentData.fetchRequest() as NSFetchRequest<CurrentData>
        let historicDataRequest = HistoricData.fetchRequest() as NSFetchRequest<HistoricData>
        
        do {
            self.currentData = try AppDelegate.context.fetch(currentDataRequest)
            self.historicData = try AppDelegate.context.fetch(historicDataRequest)
        } catch {
            fatalError()
        }
    }
    
    var launchViewWidthConstraint = NSLayoutConstraint()
    var launchViewHeightConstraint = NSLayoutConstraint()
    var launchViewVerticalConstraint = NSLayoutConstraint()
    var onboardingViewWidthConstraint = NSLayoutConstraint()
    var onboardingViewHeightConstraint = NSLayoutConstraint()
    var onboardingViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubviews(views: [backgroundImage, launchView, onboardingView])
        
        defaultConstraints(childView: backgroundImage, parentView: view)
    
        launchViewVerticalConstraint = Constraint(childView: launchView, parentView: view, constraintType: .vertical, multiplier: 1, constant: 0).setConstraint()
        launchViewWidthConstraint = Constraint(childView: launchView, parentView: view, constraintType: .proportionalWidth, multiplier: 1, constant: 0).setConstraint()
        launchViewHeightConstraint = Constraint(childView: launchView, parentView: view, constraintType: .proportionalHeight, multiplier: 0.124, constant: 0).setConstraint()
        NSLayoutConstraint.activate([launchViewWidthConstraint, launchViewHeightConstraint, launchViewVerticalConstraint, Constraint(childView: launchView, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint()])
        
        onboardingViewWidthConstraint = Constraint(childView: onboardingView, parentView: view, constraintType: .proportionalWidth, multiplier: 1, constant: 0).setConstraint()
        onboardingViewHeightConstraint = Constraint(childView: onboardingView, parentView: view, constraintType: .proportionalHeight, multiplier: 0.124, constant: 0).setConstraint()
        onboardingViewVerticalConstraint = Constraint(childView: onboardingView, parentView: view, constraintType: .vertical, multiplier: 1, constant: 0).setConstraint()
        NSLayoutConstraint.activate([onboardingViewWidthConstraint, onboardingViewHeightConstraint, onboardingViewVerticalConstraint, Constraint(childView: onboardingView, parentView: view, constraintType: .horizontal, multiplier: 1, constant: 0).setConstraint()])
    }

    func startOnboarding(){
        launchViewWidthConstraint.changeMultiplier(multiplier: onboardingWidth)
        launchViewHeightConstraint.changeMultiplier(multiplier: onboardingHeight)
        
        UIView.animate(withDuration: 1.0, delay: 0, animations: {
            self.launchView.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            onboardingCompleted = true
            self.presentView(view: OnboardingWelcomeViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: false)
            self.removeFromParent()
        })
    }
    
    func skipOnboarding(){
        onboardingView.isHidden = false
        animateConstraints(constraints: [(onboardingViewHeightConstraint, 0.89, .multiplier), (onboardingViewWidthConstraint, 1, .multiplier)])
        NSLayoutConstraint.deactivate([onboardingViewVerticalConstraint])
        NSLayoutConstraint.activate([Constraint(childView: onboardingView, parentView: view, constraintType: .bottom, multiplier: 1, constant: 0).setConstraint()])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.onboardingView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            showOnboarding = false
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.removeFromParent()
        })
    }
    
    func goTomain(){
        animateConstraints(constraints: [(launchViewWidthConstraint, 1, .multiplier),(launchViewHeightConstraint, 0.89, .multiplier)])
        NSLayoutConstraint.deactivate([launchViewVerticalConstraint])
        NSLayoutConstraint.activate([Constraint(childView: launchView, parentView: view, constraintType: .bottom, multiplier: 1, constant: 0).setConstraint()])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.launchView.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.view.layoutIfNeeded()
            self.removeFromParent()
        })
    }
}

extension LaunchViewController: LaunchViewControllerDelegate{
    
    func getCurrentCountry(name: String) -> CurrentData{
        var currentCountry: CurrentData?
        
        for country in currentData! {
            if country.location == name{
                currentCountry = country
            }
        }
        
        return currentCountry!
    }
    
    func getHistoricCountry(name: String) -> HistoricData{
        var historicCountry: HistoricData?
        
        for country in historicData! {
            if country.location == name{
                historicCountry = country
            }
        }

        return historicCountry!
    }
    
    func getCurrentData() -> [CurrentData] {
        return currentData!
    }
    
    func getHistoricData() -> [HistoricData] {
        return historicData!
    }
}

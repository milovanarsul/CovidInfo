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
        view.isHidden = DataManager.isRefreshRequired()
        return view
    }()
    
    lazy var dataLoadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        view.cornerRadius = 24
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityInidcator = UIActivityIndicatorView()
        activityInidcator.style = .large
        activityInidcator.startAnimating()
        activityInidcator.translatesAutoresizingMaskIntoConstraints = false
        return activityInidcator
    }()
    
    lazy var loadingLabel: UILabel = {
        let label = UILabel()
        label.initialize(text: "Reactualizam datele...", color: .black, font: boldFont(size: 16), alignment: .center, lines: 0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        setup()
        
        let notFirstLaunch = defaults.bool(forKey: "notFirstLaunch")

        if DataManager.isRefreshRequired() && notFirstLaunch == true{
            dataLoading()
            print("Data has been automatically refreshed!")
        } else {
            DataManager.fetchCoreData()
            AmadeusManager.loadData(country: "ROU") {result in
                AmadeusManager.currentCountryTravelData = result
                DispatchQueue.main.async { [self] in
                    notFirstLaunch ? goTomain() : startOnboarding()
                    onboardingCompleted ? skipOnboarding() : ()
                }
            }
        }
        
        if defaults.bool(forKey: "notFirstLaunch") == false{
            defaults.set(true, forKey: "notFirstLaunch")
        }
    }
    
    var launchViewWidthConstraint = NSLayoutConstraint()
    var launchViewHeightConstraint = NSLayoutConstraint()
    var launchViewVerticalConstraint = NSLayoutConstraint()
    
    var onboardingViewWidthConstraint = NSLayoutConstraint()
    var onboardingViewHeightConstraint = NSLayoutConstraint()
    var onboardingViewVerticalConstraint = NSLayoutConstraint()
    
    var dataLoadingViewWidthConstraint = NSLayoutConstraint()
    var dataLoadingViewHeightConstraint = NSLayoutConstraint()
    var dataLoadingViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubviews(views: [backgroundImage, launchView, onboardingView])
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        if DataManager.isRefreshRequired() == false {
            launchViewWidthConstraint = launchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0)
            launchViewHeightConstraint = launchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.124, constant: 0)
        } else {
            launchViewWidthConstraint = launchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: onboardingWidth, constant: 0)
            launchViewHeightConstraint = launchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: onboardingHeight, constant: 0)
        }
        
        launchViewVerticalConstraint = launchView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        launchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([launchViewWidthConstraint, launchViewHeightConstraint, launchViewVerticalConstraint])
        
        onboardingViewWidthConstraint = onboardingView.widthAnchor.constraint(equalTo: view.widthAnchor)
        onboardingViewHeightConstraint = onboardingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.124, constant: 0)
        onboardingViewVerticalConstraint = onboardingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        onboardingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([onboardingViewWidthConstraint, onboardingViewHeightConstraint, onboardingViewVerticalConstraint])
    }
    
    func dataLoading(){
        view.addSubview(dataLoadingView)
        
        dataLoadingViewWidthConstraint = dataLoadingView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0)
        dataLoadingViewHeightConstraint = dataLoadingView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.124, constant: 0)
        dataLoadingViewVerticalConstraint = dataLoadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        dataLoadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        NSLayoutConstraint.activate([dataLoadingViewWidthConstraint, dataLoadingViewHeightConstraint, dataLoadingViewVerticalConstraint])
        
        animateConstraints(constraints: [(dataLoadingViewWidthConstraint, onboardingWidth, .multiplier),(dataLoadingViewHeightConstraint, onboardingHeight, .multiplier)])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.dataLoadingView.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            self.dataLoadingComponents()
            DispatchQueue.main.async {
                DataManager.fetchData()
                AmadeusManager.loadData(country: "ROU") {result in
                    AmadeusManager.currentCountryTravelData = result
                    self.dataLoadingView.removeFromSuperview()
                    self.goTomain()
                }
            }
        })
    }
    
    func dataLoadingComponents(){
        dataLoadingView.addSubviews(views: [activityIndicator, loadingLabel])
        
        xyConstraints(childView: activityIndicator, parentView: dataLoadingView)
        loadingLabel.centerXAnchor.constraint(equalTo: dataLoadingView.centerXAnchor).isActive = true
        loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10).isActive = true
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
        self.launchView.isHidden = false
        animateConstraints(constraints: [(launchViewWidthConstraint, 1, .multiplier),(launchViewHeightConstraint, 0.89, .multiplier)])
        NSLayoutConstraint.deactivate([launchViewVerticalConstraint])
        NSLayoutConstraint.activate([Constraint(childView: launchView, parentView: view, constraintType: .bottom, multiplier: 1, constant: 0).setConstraint()])
        
        UIView.animate(withDuration: defaultAnimationDuration, animations: {
            self.launchView.layoutIfNeeded()
            //self.view.layoutIfNeeded()
        }, completion: { (finished: Bool) in
            self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
            self.view.layoutIfNeeded()
            self.removeFromParent()
        })
    }
}

//
//  LaunchViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.02.2022.
//

import UIKit
import CoreData

class LaunchViewController: UIViewController {
    
    lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "FirstOnboarding")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var iconTile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Icon & Title")!
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var bottomDescription: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "An app by Milovan Arsul")!
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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if targetEnvironment(simulator)
            defaults.set(true, forKey: "certifficateEnrolled")
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
    }
    
    var launchViewWidthConstraint = NSLayoutConstraint()
    var launchViewHeightConstraint = NSLayoutConstraint()
    var launchViewVerticalConstraint = NSLayoutConstraint()
    
    func setup(){
        view.addSubviews(views: [backgroundImage, iconTile, bottomDescription])
        defaultConstraints(childView: backgroundImage, parentView: view)
        
        let iconTitleConstraints = Constraints(childView: iconTile, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 140),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        iconTitleConstraints.addConstraints()
        
        let bottomDescriptionConstraints = Constraints(childView: bottomDescription, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 120),
            Constraint(constraintType: .height, multiplier: 1, constant: 25),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 34)
        ])
        bottomDescriptionConstraints.addConstraints()
        
        let notFirstLaunch = defaults.bool(forKey: "notFirstLaunch")
        
        if notFirstLaunch == false {
            print("Onboarding presented")
            onboarding()
        }
        
        if notFirstLaunch && DataManager.isRefreshRequired() == false{
            print("Main presented")
            main()
        }
        
        if DataManager.isRefreshRequired() && notFirstLaunch == true{
            print("Data has been refreshed")
            refresh()
        }
    }
    
    func onboarding(){
        view.addSubview(launchView)
        
        launchViewWidthConstraint = launchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: onboardingWidth, constant: 0)
        launchViewHeightConstraint = launchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: onboardingHeight, constant: 0)
        launchViewVerticalConstraint = launchView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        launchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([launchViewWidthConstraint, launchViewHeightConstraint, launchViewVerticalConstraint])
        
        UIView.animate(withDuration: 0.6, animations: {
            self.launchView.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            DispatchQueue.main.async { [self] in
                self.presentView(view: OnboardingViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: false)
                removeFromParent()
                defaults.set(true, forKey: "notFirstLaunch")
            }
        })
    }
    
    func refresh(){
        view.addSubview(launchView)
        
        launchViewWidthConstraint = launchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: onboardingWidth, constant: 0)
        launchViewHeightConstraint = launchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55, constant: 0)
        launchViewVerticalConstraint = launchView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        launchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        NSLayoutConstraint.activate([launchViewWidthConstraint, launchViewHeightConstraint, launchViewVerticalConstraint])
        
        UIView.animate(withDuration: 0.6, animations: {
            self.launchView.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            DispatchQueue.main.async { [self] in
                presentView(view: OnboardingViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: false)
                removeFromParent()
                delegates.onboardingPVC.goToPage(pageIndex: 8, direction: .forward)
                delegates.onboarding.downloadData(dataRequest: .refresh)
            }
        })
    }
    
    func main(){
        view.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomDescription.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 30).isActive = true
        activityIndicator.startAnimating()
        
        DataManager.loadData(){finished in
            if finished{
                DispatchQueue.main.async { [self] in
                    activityIndicator.removeFromSuperview()
                    view.addSubview(launchView)
                    
                    launchViewWidthConstraint = launchView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1, constant: 0)
                    launchViewHeightConstraint = launchView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.89, constant: 0)
                    launchView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                    launchView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                    
                    NSLayoutConstraint.activate([launchViewWidthConstraint, launchViewHeightConstraint])
                    
                    UIView.animate(withDuration: 0.6, animations: {
                        self.launchView.layoutIfNeeded()
                    }, completion: {(finished: Bool) in
                        self.presentView(view: MainViewController(), animated: false, presentationStyle: .fullScreen, dismissPrevious: true)
                        self.view.layoutIfNeeded()
                        self.removeFromParent()
                    })
                }
            }
        }
    }
}

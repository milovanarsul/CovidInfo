//
//  MainViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.01.2022.
//

import UIKit
import Lottie
import BetterSegmentedControl

class MainViewController: UIViewController {
    lazy var navigationBar: UIView = {
        let view = CustomNavigationBar()
        view.setup()
        delegates.navigationBar = view
        view.backgroundColor = .white
        return view
    }()
    
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        return activityIndicator
    }()
    
    lazy var contentViewContent: UIView = {
        let view = UIView()
        CovidInfo.embed.mainPageViewController(parent: self, container: view)
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.dropShadow = true
        return view
    }()
    
    lazy var certifficateButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Certificatul tau", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
        button.addTarget(self, action: #selector(certifficateButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    lazy var planTripButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Planifica-ti calatoria", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "globe.europe.africa"))
        button.addTarget(self, action: #selector(planTripButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Filtreaza datele", titleColor: .white, cornerRadius: 24, font: boldFont(size: 13), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10), image: UIImage(systemName: "slider.vertical.3"))
        button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var compareCountries: UIButton = {
        let button = UIButton()
        button.initialize(title: "Compara tari", titleColor: .white, cornerRadius: 24, font: boldFont(size: 13), backgroundColor: signatureDarkBlue, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10), image: UIImage(systemName: "chart.pie"))
        button.addTarget(self, action: #selector(compareCountriesButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Confirma", titleColor: .white, cornerRadius: 24, font: boldFont(size: 13), backgroundColor: greenColor)
        button.addTarget(self, action: #selector(confirmButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.initialize(title: "Anuleaza", titleColor: .white, cornerRadius: 24, font: boldFont(size: 13), backgroundColor: redColor)
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var statisticsActions: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 10)
        stackView.addAranagedSubviews(views: [filterButton, compareCountries])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var countryPickerActions: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 10)
        stackView.addAranagedSubviews(views: [confirmButton, cancelButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        return stackView
    }()
    
    lazy var tabBar: UIView = {
        let view = CustomTabBar()
        view.setup()
        view.backgroundColor = .white
        view.dropShadow = true
        view.cornerRadius = 10
        return view
    }()
    
    lazy var tabBarExtension: UIView = {
        let view = TabBarExtension()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var countryPicker: UIView = {
        let view = UIView()
        embed.countryPicker(parent: self, container: view)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setup()
        tabAnimation(visibility: .show)
    }
    
    var tabBarBottomConstraint = NSLayoutConstraint()
    var tabBarHeightConstraint = NSLayoutConstraint()
    var tabBarWidthConstraint = NSLayoutConstraint()
    var certifficateButtonVerticalConstraint = NSLayoutConstraint()
    var navigationBarTopConstraint = NSLayoutConstraint()
    var contentViewTopConstraint = NSLayoutConstraint()
    var planTripButtonVerticalConstraint = NSLayoutConstraint()
    var statisticsActionsVerticalConstraint = NSLayoutConstraint()
    var countryPickerActionsVerticalConstraints = NSLayoutConstraint()
    var tabBarExtenstionBottomConstraint = NSLayoutConstraint()
    var tabBarExtensionWidthConstraint = NSLayoutConstraint()
    
    func setup(){
        
        view.backgroundColor = .white
        view.addSubviews(views: [navigationBar, contentView, tabBarExtension ,certifficateButton, planTripButton, statisticsActions ,countryPickerActions, tabBar, countryPicker])
        view.sendSubviewToBack(countryPicker)
        
        let navigationBarConstraints = Constraints(childView: navigationBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 90),
        ])
        navigationBarConstraints.addConstraints()
        navigationBarTopConstraint = navigationBar.topAnchor.constraint(equalTo: view.topAnchor)
        navigationBarTopConstraint.isActive = true
        
        let countryPickerConstraints = Constraints(childView: countryPicker, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        countryPickerConstraints.addConstraints()
        countryPicker.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 5).isActive = true
         
        let contentViewConstraints = Constraints(childView: contentView, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        contentViewConstraints.addConstraints()
        contentViewTopConstraint = contentView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 5)
        contentViewTopConstraint.isActive = true
        
        contentView.addSubview(contentViewContent)
        defaultConstraints(childView: contentViewContent, parentView: contentView)
        
        let tabBarConstraints = Constraints(childView: tabBar, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)
        ])
        tabBarConstraints.addConstraints()
        
        tabBarHeightConstraint = tabBar.heightAnchor.constraint(equalToConstant: 50)
        tabBarWidthConstraint = tabBar.widthAnchor.constraint(equalToConstant: 352)
        tabBarBottomConstraint = view.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor, constant: -100)
        NSLayoutConstraint.activate([tabBarWidthConstraint,tabBarHeightConstraint,tabBarBottomConstraint])
        
        certifficateButtonVerticalConstraint = tabBar.topAnchor.constraint(equalTo: certifficateButton.bottomAnchor, constant: -45)
        certifficateButtonVerticalConstraint.isActive = true
        certifficateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        planTripButtonVerticalConstraint = tabBar.topAnchor.constraint(equalTo: planTripButton.bottomAnchor, constant: -45)
        NSLayoutConstraint.activate([
            planTripButtonVerticalConstraint,
            planTripButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        statisticsActionsVerticalConstraint = tabBar.topAnchor.constraint(equalTo: statisticsActions.bottomAnchor, constant: -45)
        NSLayoutConstraint.activate([
            statisticsActionsVerticalConstraint,
            statisticsActions.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 0.9, constant: 0),
            statisticsActions.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 0.7, constant: 0),
            statisticsActions.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        countryPickerActionsVerticalConstraints = tabBar.topAnchor.constraint(equalTo: countryPickerActions.bottomAnchor, constant: -45)
        NSLayoutConstraint.activate([
            countryPickerActionsVerticalConstraints,
            countryPickerActions.widthAnchor.constraint(equalTo: tabBar.widthAnchor, multiplier: 0.9, constant: 0),
            countryPickerActions.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 0.7, constant: 0),
            countryPickerActions.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        tabBarExtension.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tabBarExtensionWidthConstraint = tabBarExtension.widthAnchor.constraint(equalToConstant: 352)
        tabBarExtensionWidthConstraint.isActive = true
        tabBarExtension.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tabBarExtenstionBottomConstraint = tabBarExtension.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 50)
        tabBarExtenstionBottomConstraint.isActive = true
    }
    
    @objc func certifficateButtonTapped(_ sender: UIButton) {
        defaults.bool(forKey: "certifficateEnrolled") ? certifficateModal() : enrollCertifficate()
    }
    
    @objc func planTripButtonTapped(_ sender: UIButton){
        let modal = TripPlannerViewController()
        modal.modalPresentationStyle = .formSheet
        modal.transitioningDelegate = self
        modal.isModalInPresentation = true
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    @objc func filterButtonTapped(_ sender: UIButton){
        let modal = FilterDataViewController()
        modal.view.backgroundColor = .white
    
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        
        present(modal, animated: true, completion: nil)
    }
    
    @objc func compareCountriesButtonTapped(_ sender: UIButton){
        let modal = CompareCountriesViewController()
        modal.view.backgroundColor = .white
        modal.modalPresentationStyle = .formSheet
        modal.transitioningDelegate = self
        modal.isModalInPresentation = true
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = false
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    @objc func confirmButtonTapped(_ sender: UIButton){
        defaults.setValue(auxManualLocation, forKey: "manualCountry")
        defaults.set(false, forKey: "useAutomaticLocation")
        
        refreshData()
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton){
        
    }
}

extension MainViewController: MainDelegate{
    func tabAnimation(visibility: ViewVisibility){
        tabBarVisibility(tabBarVisibility: visibility)
        certifficateButtonAnimation(visibility: visibility)
    }
    
    func navigationBarAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            navigationBarTopConstraint.constant = 0
        case .hide:
            navigationBarTopConstraint.constant = -100
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.navigationBar.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func refreshData(){
        countryPickerActionsAnimaiton(visibility: .hide)
        animateContentView(size: 5)
        tabAnimation(visibility: .hide)
        navigationBarAnimation(visibility: .hide)
        contentViewContent.isHidden = true
        contentView.addSubview(activityIndicator)
        xyConstraints(childView: activityIndicator, parentView: contentView)
        activityIndicator.startAnimating()
        
        DataManager.changeManualLocation(){ [self] finished in
            if finished{
                DispatchQueue.main.async { [self] in
                    activityIndicator.removeFromSuperview()
                    DataManager.reloadViews()
                    contentView.isHidden = false
                    tabAnimation(visibility: .show)
                    delegates.navigationBar.simulateLocationButtonTap(viewVisibility: .hide)
                    navigationBarAnimation(visibility: .show)
                    certifficateButtonAnimation(visibility: .hide)
                    
                    let currentIndex = delegates.tabBar.getCurrentIndex()
                    switch currentIndex{
                    case 1:
                        planTripButtonAnimation(visibility: .show)
                    case 3:
                        statisticsActionsAnimation(visibility: .show)
                    default:
                        ()
                    }
                }
            }
        }
    }
    
    func contentViewVisibility(visibility: ViewVisibility){
        switch visibility {
        case .show:
            contentViewContent.isHidden = false
        case .hide:
            contentViewContent.isHidden = true
        }
    }
    
    func animateContentView(size: CGFloat){
        contentViewTopConstraint.constant = size
        
        UIView.animate(withDuration: 0.4, animations: {
            self.contentView.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func certifficateButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            certifficateButton.isHidden = false
            certifficateButtonVerticalConstraint.constant = 10
        case .hide:
            certifficateButton.isHidden = true
            certifficateButtonVerticalConstraint.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.certifficateButton.layoutIfNeeded()
        })
    }
    
    func planTripButtonAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            planTripButton.isHidden = false
            planTripButtonVerticalConstraint.constant = 10
        case .hide:
            planTripButton.isHidden = true
            planTripButtonVerticalConstraint.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.planTripButton.layoutIfNeeded()
        })
    }
    
    func statisticsActionsAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            statisticsActions.isHidden = false
            statisticsActionsVerticalConstraint.constant = 15
        case .hide:
            statisticsActions.isHidden = true
            statisticsActionsVerticalConstraint.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.statisticsActions.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func countryPickerActionsAnimaiton(visibility: ViewVisibility){
        switch visibility {
        case .show:
            countryPickerActions.isHidden = false
            countryPickerActionsVerticalConstraints.constant = 15
        case .hide:
            countryPickerActions.isHidden = true
            countryPickerActionsVerticalConstraints.constant = -45
        }
        
        UIView.animate(withDuration: 0.6, animations: {
            self.countryPickerActions.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func tabBarVisibility(tabBarVisibility: ViewVisibility) {
        switch tabBarVisibility{
        case .hide:
            self.tabBarBottomConstraint.constant = -100
        case .show:
            self.tabBarBottomConstraint.constant = 30
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            self.tabBar.layoutIfNeeded()
        })
    }
    
    func certifficateModal(){
        let modal = UIViewController()
        let view = CertifficateView()
        view.setup()
        modal.view = view
        
        if let sheet = modal.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func enrollCertifficate(){
        let modal = EnrollCertifficateViewController()
        modal.modalPresentationStyle = .formSheet
        modal.transitioningDelegate = self
        
        if let sheet = modal.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 24
        }
        present(modal, animated: true, completion: nil)
    }
    
    func dimissModal(completion: @escaping (() -> Void)) {
        dismiss(animated: true, completion: completion)
    }
    
    func updateCertifficateButton(){
        self.certifficateButton.initialize(title: defaults.bool(forKey: "certifficateEnrolled") ? "Certificatul tau" : "Inroleaza certificat", titleColor: .white, cornerRadius: 24, font: boldFont(size: 14), backgroundColor: defaults.bool(forKey: "certifficateEnrolled") ? signatureDarkBlue : .red, contentInsets: NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20), image: UIImage(systemName: "qrcode.viewfinder"))
    }
    
    func tabBarActionsVisibility(visibility: ViewVisibility){
        let currentIndex = delegates.tabBar.getCurrentIndex()
        
        switch currentIndex{
        case 0:
            certifficateButtonAnimation(visibility: visibility)
        case 1:
            if delegates.info.getCategoriesCurrentIndex() == 0{
                planTripButtonAnimation(visibility: visibility)
            }
        case 2:
            ()
        case 3:
            statisticsActionsAnimation(visibility: visibility)
        default:
            ()
        }
    }
    
    func tabBarExtensionAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            tabBarExtension.isHidden = false
            tabBarExtenstionBottomConstraint.constant = 5
        case .hide:
            tabBarExtenstionBottomConstraint.constant = 50
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.tabBarExtension.layoutIfNeeded()
            self.view.layoutIfNeeded()
        }, completion: {(finished: Bool) in
            if visibility == .hide{
                self.tabBarExtension.isHidden = true
            }
        })
    }
    
    func tabBarScrollAnimation(visibility: ViewVisibility){
        switch visibility {
        case .show:
            tabBarHeightConstraint.constant = 50
            tabBarWidthConstraint.constant = 352
            tabBarExtensionWidthConstraint.constant = 352
            tabBarBottomConstraint.constant = 30
            tabBarActionsVisibility(visibility: .show)
            delegates.customTabBar.tabBarScroll(visibility: .show)
            delegates.customTabBar.goToTopButtonVisibily(visibily: .hide)
        case .hide:
            tabBarHeightConstraint.constant = 70
            tabBarWidthConstraint.constant = 414
            tabBarExtensionWidthConstraint.constant = 414
            tabBarBottomConstraint.constant = 0
            tabBarActionsVisibility(visibility: .hide)
            delegates.customTabBar.tabBarScroll(visibility: .hide)
            delegates.customTabBar.goToTopButtonVisibily(visibily: .show)
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            self.tabBar.layoutIfNeeded()
            self.tabBarExtension.layoutIfNeeded()
            self.view.layoutIfNeeded()
        })
    }
    
    func locationDenied(){
        let alert = UIAlertController(title: "Accesul la locatie a fost restrictionat", message: "Reactiveaza accesul la locatie din Setari > CovidInfo > Localizare > La utilizarea aplicatiei", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.presentedViewController?.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if dismissed is EnrollCertifficateViewController {
            delegates.enrollCertifficate.stopCapture()
        }
        return nil
    }
}

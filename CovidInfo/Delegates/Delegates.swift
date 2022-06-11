//
//  Delegates.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 04.02.2022.
//

import Foundation
import UIKit

class Delegates{
    var onboardingPVC: OnboardingPageViewControllerDelegate! = nil
    var onboarding: OnboardingDelegate! = nil
    var onboardingView: OnboardingViewDelegate! = nil
    var onboardingDownload: OnboardingDownload! = nil
    var main: MainDelegate! = nil
    var navigationBar: NavigationBarDelegate! = nil
    var tabBar: TabBarDelegate! = nil
    var homePage: HomePageDelegate! = nil
    var staticInfo: StaticDelegate! = nil
    var triaj: TriajDelegate! = nil
    var triajSub: TriajSubDelegate! = nil
    var customPresentation: CustomPresentationDelegate! = nil
    var enrollCertifficate: EnrollCertifficateDelegate! = nil
    var news: NewsDelegate! = nil
    var customTabBar: CustomTabBarDelegate! = nil
    var infoPage: InfoPageViewControllerDelegate! = nil
    var infoCardsCollectionView: InfoCardsCollectionViewDelegate! = nil
    var info: InfoViewControllerDelegate! = nil
    var statistics: StatisticsViewControllerDelegate! = nil
    var tripPlanner: TripPlannerDelegate! = nil
    var compareCountries: CompareCountries! = nil
    var compareCountriesPVC: CompareCountriesPageViewControllerDeleagate! = nil
    var countryController: CountryViewControllerDelegate! = nil
    var home: HomeViewControllerDelegate! = nil
    var countryPicker: CountryPickerViewDelegate! = nil
    
    init(){}
}

let delegates: Delegates = Delegates()

@objc protocol OnboardingPageViewControllerDelegate{
    @objc optional func nextPage()
    @objc optional func getCurrentIndex() -> Int
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

protocol OnboardingDelegate{
    func startTutorial()
    func skipTutorial()
    func setPageControl()
    func enrollCertifficate()
    func dismissModal(completion: @escaping (() -> Void))
    func pageControlVisibility(visibility: Bool)
    func downloadData(dataRequest: DataRequest)
    func goToMain()
}

protocol OnboardingViewDelegate{
    func hideNextButton()
}

protocol OnboardingDownload{
    func downloadData(dataRequest: DataRequest)
}

protocol MainDelegate{
    func certifficateButtonAnimation(visibility: ViewVisibility)
    func tabAnimation(visibility: ViewVisibility)
    func tabBarVisibility(tabBarVisibility: ViewVisibility)
    func certifficateModal()
    func enrollCertifficate()
    func dimissModal(completion: @escaping (() -> Void))
    func updateCertifficateButton()
    func animateContentView(size: CGFloat)
    func planTripButtonAnimation(visibility: ViewVisibility)
    func statisticsActionsAnimation(visibility: ViewVisibility)
    func refreshData()
    func countryPickerActionsAnimaiton(visibility: ViewVisibility)
    func contentViewVisibility(visibility: ViewVisibility)
    func tabBarExtensionAnimation(visibility: ViewVisibility)
    func tabBarScrollAnimation(visibility: ViewVisibility)
    func navigationBarAnimation(visibility: ViewVisibility)
    func locationDenied()
}

protocol NavigationBarDelegate{
    func setup(page: Page)
    func buttonSlider(sliderType: currentPageButtonSlider)
    func certifficateButtonAnimation(visibility: ViewVisibility)
    func changeContainerViewBottomConstraint(visibility: Bool)
    func locationButtonAnimation(visibility: ViewVisibility)
    func locationButtonContentAnimation(visibility: ViewVisibility)
    func simulateLocationButtonTap(viewVisibility: ViewVisibility)
}

protocol TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
    func getCurrentPresentedViewController() -> UIViewController
    func getCurrentIndex() -> Int
    func refresh()
}

protocol HomePageDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
    func updateNavigationBar(page: Page)
}

protocol StaticDelegate{
    func getCards() -> ([SimptomeAndPreventieData], UIColor, Int)
}

protocol TriajDelegate{
    func nextPage(index: Int)
    func currentIndex() -> Int
    func goToStart()
    func endTriaj()
}

protocol TriajSubDelegate{
    func resizeContainerView()
    func resetContainerView()
}

protocol CustomPresentationDelegate{
    func setPresentationHeight(presentationHeight: PresentationSize)
}

protocol EnrollCertifficateDelegate{
    func stopCapture()
}

protocol NewsDelegate{
    func scrollToTop()
    func refreshData()
    func externalSourceArticleTap(index: Int)
}

protocol CustomTabBarDelegate{
    func goToTopButtonVisibily(visibily: ViewVisibility)
    func goToPage(index: Int)
    func currentButtonSliderAnimation()
    func tabBarScroll(visibility: ViewVisibility)
}

protocol InfoPageViewControllerDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

protocol InfoCardsCollectionViewDelegate{
    func getInfoData(index: Int) -> InfoCardsData
    func getCurrentIndexTextHeight() -> CGFloat
    func scrollToTop()
}

protocol InfoViewControllerDelegate{
    func getCardsViewController() -> UIViewController
    func setCategoriesIndex(index: Int)
    func viewsVisibility(visibility: Bool)
    func variantsScroll()
    func getCategoriesCurrentIndex() -> Int
}

protocol CountryPickerDelegate{
    func locationPicker(description: String)
}

protocol StatisticsViewControllerDelegate {
    func refreshTableView()
    func updateDate(text: String)
    func scrollToTop()
    func historicData()
}

protocol TripPlannerDelegate{
    func animateDepartureView()
    func animateArrivalView()
    func result()
    func expandCell(type: TripViewType)
    func refreshTableView()
}

protocol CompareCountries {
    func animateCountry1()
    func animateCountry2()
    func result()
}

protocol CompareCountriesPageViewControllerDeleagate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

protocol CountryViewControllerDelegate{
    func refreshTableView()
    func scrollToTop()
}

protocol HomeViewControllerDelegate {
    func refreshTableView()
    func scrollToTop()
}

protocol CountryPickerViewDelegate{
    func hideKeyboard()
}

protocol TripPlannerCountryPickerDelegate{
    func dismissKeyboard()
}

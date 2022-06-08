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
    func dimissModal(completion: @escaping (() -> Void))
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
    func tabBarVisibility(tabBarVisibility: ViewVisibility)
    func certifficateModal()
    func enrollCertifficate()
    func dimissModal(completion: @escaping (() -> Void))
    func updateCertifficateButton()
    func scrollAnimation(size: CGFloat)
    func tabBarScrollAnimation(visibility: ViewVisibility, resetsAnimation: Bool)
    func tabAnimation(visibility: ViewVisibility)
    func tabBarExtension(visibility: ViewVisibility)
    func animateContentView(size: CGFloat)
    func planTripButtonAnimation(visibility: ViewVisibility)
    func statisticsActionsAnimation(visibility: ViewVisibility)
    func waitingModal()
}

protocol NavigationBarDelegate{
    func setup(page: Page)
    func buttonSlider(sliderType: currentPageButtonSlider)
    func certifficateButtonAnimation(visibility: ViewVisibility)
    func changeContainerViewBottomConstraint(visibility: Bool)
    func locationButtonAnimation(visibility: ViewVisibility)
    func externalTapLocationButton()
}

protocol TabBarDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
    func getCurrentPresentedViewController() -> UIViewController
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
    func increaseBottomConstraint(size: CGFloat)
    func goToTopButtonVisibily(visibily: ViewVisibility)
    func goToPage(index: Int)
}

protocol InfoPageViewControllerDelegate{
    func goToPage(pageIndex: Int, direction: UIPageViewController.NavigationDirection)
}

protocol InfoCardsCollectionViewDelegate{
    func getInfoData(index: Int) -> InfoCardsData
    func getCurrentIndexTextHeight() -> CGFloat

}

protocol InfoViewControllerDelegate{
    func getCardsViewController() -> UIViewController
    func setCategoriesIndex(index: Int)
    func viewsVisibility(visibility: Bool)
}

protocol CountryPickerDelegate{
    func locationPicker(description: String)
}

protocol StatisticsViewControllerDelegate {
    func refreshTableView()
    func updateDate(text: String)
}

protocol TripPlannerDelegate{
    func animateDepartureView()
    func animateArrivalView()
    func result()
    func expandCell(type: TripViewType)
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
}

protocol HomeViewControllerDelegate {
    func refreshTableView()
}

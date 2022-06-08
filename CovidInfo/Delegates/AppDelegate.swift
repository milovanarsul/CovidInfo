//
//  AppDelegate.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 12.01.2022.
//

import UIKit
import CoreData
import Firebase
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static let locationManager = CLLocationManager()
    
    static let geoCoder = CLGeocoder()
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var locationCountry: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        FirebaseManager.loadData()
        
        AppDelegate.locationManager.delegate = self

        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension AppDelegate: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted, .notDetermined:
            print("Location denied")
            if appDidLoad{
                if UIApplication.shared.topMostViewController() is OnboardingViewController && delegates.onboardingPVC.getCurrentIndex?() == 6{
                    delegates.onboardingPVC.goToPage(pageIndex: 7, direction: .forward)
                }
            }
        default:
            AppDelegate.locationManager.requestLocation()
            print("Location authorized")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        AppDelegate.geoCoder.reverseGeocodeLocation(locations.first!){ placemarks, _ in
            if let place = placemarks?.first?.country {
                var country: String?
                for (key,value) in enISOCountries{
                    if value == place{
                        country = roISOCountries[key]!
                        
                        defaults.set(country, forKey: "automaticCountry")
                        defaults.set(true, forKey: "useAutomaticLocation")
                        if UIApplication.shared.topMostViewController() is OnboardingViewController && delegates.onboardingPVC.getCurrentIndex?() == 6{
                            delegates.onboarding.downloadData(dataRequest: .all)
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if let error = error as? CLError, error.code == .denied {
            AppDelegate.locationManager.stopMonitoringSignificantLocationChanges()
            
            if appDidLoad{
                if UIApplication.shared.topMostViewController() is OnboardingViewController && delegates.onboardingPVC.getCurrentIndex?() == 6{
                    delegates.onboardingView.hideNextButton()
                    delegates.onboardingPVC.goToPage(pageIndex: 7, direction: .forward)
                }
            }
           return
        }
    }
}

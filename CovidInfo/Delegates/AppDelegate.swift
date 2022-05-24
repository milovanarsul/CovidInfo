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
    let locationManager = CLLocationManager()
    
    static let geoCoder = CLGeocoder()
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var locationCountry: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        if OnboardingManager.shared.isFirstLaunch == false{
            print("enters here")
            DataManager.loadDataIfNeeded()
        }
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
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
            if defaults.string(forKey: "manualCountry") == nil{
                defaults.set(false, forKey: "automaticLocation")
            }
        case .authorizedWhenInUse:
          locationManager.requestLocation()
        case .authorizedAlways:
          locationManager.requestLocation()
        default:
          ()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        AppDelegate.geoCoder.reverseGeocodeLocation(locations.first!){ placemarks, _ in
            if let place = placemarks?.first?.country {
                var country: String?
                for (key,value) in enISOCountries{
                    if value == place{
                        country = roISOCountries[key]!
                    }
                }
                AppDelegate.locationCountry = country
                
                if defaults.string(forKey: "manualCountry") == nil{
                    defaults.set(true, forKey: "automaticLocation")
                }
                
                DataManager.fetchData()
                DataManager.countryData()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError \(error.localizedDescription)")
        if let error = error as? CLError, error.code == .denied {
           locationManager.stopMonitoringSignificantLocationChanges()
           return
        }
    }
}

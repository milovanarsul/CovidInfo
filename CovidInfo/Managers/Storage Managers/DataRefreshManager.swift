//
//  DataRefreshManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 23.04.2022.
//

import Foundation

class DataRefreshManager: NSObject {
    static let shared = DataRefreshManager()
    private let defaults = UserDefaults.standard
    private let defaultsKey = "lastRefresh"
    private let calendar = Calendar.current
    
    func forceLoadData(){
        DispatchQueue.main.async {
            digi24(articleCount: 40)
            stiriOficiale()
        }
    }
    
    func loadDataIfNeeded(){
        if isRefreshRequired(){
            deleteAllCustomEntityObjects(context: AppDelegate.context)
            DispatchQueue.global(qos: .background).async {
                digi24(articleCount: 40)
                stiriOficiale()
                fetchVariantsData()
            }
            print("data has been refreshed!")
            defaults.set(Date(), forKey: defaultsKey)
        } else {
            print("data has not been refreshed!")
        }
    }
    
    private func isRefreshRequired() -> Bool {
        guard let lastRefreshDate = defaults.object(forKey: defaultsKey) as? Date else {
            return true
        }
        
        if let timeDifference = calendar.dateComponents([.hour], from: lastRefreshDate, to: Date()).hour, timeDifference > 24 {
            return true
        } else {
            return false
        }
    }
}

//
//  Amadeus Manager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 27.05.2022.
//

import Foundation
import Amadeus
import SwiftyJSON
import UIKit

class AmadeusManager{
    private static let clientID = "c85NkWetbVYNfZKk6WcJb9uIHDY2yLf3"
    private static let clientSecret = "lUyZ1GbGAawrThs1"
    
    public static var amadeus: Amadeus = Amadeus(client_id: clientID, client_secret: clientSecret)
    
    static var countryTravelData: [CountryTravelModel]?
    
    static func getData(country: String){
        let iso2Country = ISO3ToISO2[country]
        
        DispatchQueue.main.async {
            amadeus.client.get(path: "/v1/duty-of-care/diseases/covid19-area-report",
                               params: ["countryCode" : iso2Country!],
                               onCompletion: { result in
                switch result {
                case .success(let response):
                    do {
                        let json = try response.data.rawData()
                        parseAPIResult(json: json)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    static func parseAPIResult(json: Data){
        do {
            let data = try JSONDecoder().decode(TravelAdvice.self, from: json)
            
            /*
            print("1: \(risks[data.diseaseRiskLevel!]!)")
            print("2: \(risks[data.diseaseInfection!.level!]!)")
            print("3: \(data.diseaseInfection!.rate!)")
            print("4: \(status[data.areaPolicy!.status!]!)")
            print("5: \(data.areaPolicy!.text!)")
            print("6: \(affirmative[data.areaAccessRestriction!.entry!.ban!]!)")
            print("7: \(data.areaAccessRestriction!.entry!.text!)")
            print("8: \(affirmative[data.areaAccessRestriction!.diseaseVaccination!.isRequired!]!)")
            print("9: \(data.areaAccessRestriction!.diseaseVaccination!.text!)")
            print("10: \(affirmative[data.areaAccessRestriction!.diseaseTesting!.isRequired!]!)")
            print("11: \(data.areaAccessRestriction!.mask!.isRequired!)")
            print("12: \(data.areaAccessRestriction!.mask!.text!)")
            */
            
            let diseaseRiskLevel = CountryTravelModel(icon: UIImage(systemName: "cross")!, title: "Risc de calatorie", subtitle: risks[data.diseaseRiskLevel!]!)
            let diseaseInfection = CountryTravelModel(icon: UIImage(systemName: "allergens")!, title: "Risc de imbolnavire", subtitle: risks[data.diseaseInfection!.level!]!, text: "Rata de imbolnavire: \(data.diseaseInfection!.rate!)")
            let areaPolicy = CountryTravelModel(icon: UIImage(systemName: "exclamationmark.triangle")!, title: "Restrictii", subtitle: status[data.areaPolicy!.status!]!, text: data.areaPolicy!.text!)
            let entry = CountryTravelModel(icon: UIImage(systemName: "arrow.forward.square")!, title: "Reguli de intrare in tara", subtitle: affirmative[data.areaAccessRestriction!.entry!.ban!]!, text: data.areaAccessRestriction!.entry!.text)
            let quarantine = CountryTravelModel(icon: UIImage(systemName: "pills")!, title: "Carantina necesara", subtitle: ("None", .black))
            let vaccination = CountryTravelModel(icon: UIImage(systemName: "bandage")!, title: "Vaccinare necesara", subtitle: affirmative[data.areaAccessRestriction!.diseaseVaccination!.isRequired!]!, text: data.areaAccessRestriction!.diseaseVaccination!.text)
            let testing = CountryTravelModel(icon: UIImage(systemName: "heart.text.square")!, title: "Testare necesara", subtitle: affirmative[data.areaAccessRestriction!.diseaseTesting!.isRequired!]!)
            let mask = CountryTravelModel(icon: UIImage(systemName: "facemask")!, title: "Masca necesara", subtitle: (data.areaAccessRestriction!.mask!.isRequired!, .yellow), text: data.areaAccessRestriction!.mask!.text!)
            
            countryTravelData = [diseaseRiskLevel, diseaseInfection, areaPolicy, entry, quarantine, vaccination, testing, mask]
            //print(countryTravelData?.count)
            
        } catch {
            print(error)
        }
    }
    
}

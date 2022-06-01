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
    static var currentCountryTravelData: [CountryTravelModel]?
    
    private static let clientID = "gPNtNjoHpWKPffuIGpwIGDYoU9fMNfxM"
    private static let clientSecret = "kFC1NGMvswfS1ete"
    private static let amadeus: Amadeus = Amadeus(client_id: clientID, client_secret: clientSecret)
    
    static func loadData(country: String, completion: @escaping ([CountryTravelModel]?) -> ()){
        let iso2Country = ISO3ToISO2[country]
        
        amadeus.client.get(path: "/v1/duty-of-care/diseases/covid19-area-report",
                          params: ["countryCode" : iso2Country!],
                          onCompletion: {  result in
           switch result {
           case .success(let response):
               do {
                   let json = try response.data.rawData()
                   let data = try JSONDecoder().decode(TravelAdvice.self, from: json)
                   
                   let diseaseRiskLevel = CountryTravelModel(icon: UIImage(systemName: "cross")!, title: "Risc de calatorie", subtitle: risks[data.diseaseRiskLevel!]!)
                   let diseaseInfection = CountryTravelModel(icon: UIImage(systemName: "allergens")!, title: "Risc de imbolnavire", subtitle: risks[data.diseaseInfection!.level!]!, text: "Rata de imbolnavire: \(data.diseaseInfection!.rate!)")
                   let areaPolicy = CountryTravelModel(icon: UIImage(systemName: "exclamationmark.triangle")!, title: "Restrictii", subtitle: status[data.areaPolicy!.status!]!, text: data.areaPolicy!.text!)
                   let entry = CountryTravelModel(icon: UIImage(systemName: "arrow.forward.square")!, title: "Reguli de intrare in tara", subtitle: affirmative[data.areaAccessRestriction!.entry!.ban!]!, text: data.areaAccessRestriction!.entry!.text!)
                   let quarantine = CountryTravelModel(icon: UIImage(systemName: "pills")!, title: "Carantina necesara", subtitle: ("None", .black))
                   let vaccination = CountryTravelModel(icon: UIImage(systemName: "bandage")!, title: "Vaccinare necesara", subtitle: affirmative[data.areaAccessRestriction!.diseaseVaccination!.isRequired!]!, text:  data.areaAccessRestriction!.diseaseVaccination!.text!)
                   let testing = CountryTravelModel(icon: UIImage(systemName: "heart.text.square")!, title: "Testare necesara", subtitle: affirmative[data.areaAccessRestriction!.diseaseTesting!.isRequired!]!)
                   let mask = CountryTravelModel(icon: UIImage(systemName: "facemask")!, title: "Masca necesara", subtitle: (data.areaAccessRestriction!.mask!.isRequired!, .yellow), text: data.areaAccessRestriction!.mask!.text!)
                   
                   completion([diseaseRiskLevel, diseaseInfection, areaPolicy, entry, quarantine, vaccination, testing, mask])
                   print("Amadeus Manager loaded data!")
               } catch {
                   print(error)
                   completion(nil)
               }
           case .failure(let error):
               print(error)
               completion(nil)
           }
        })
    }
}
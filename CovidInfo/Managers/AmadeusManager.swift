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
    static var departureCountryTravelData: [CountryTravelModel]?
    static var arrivalCountryTravelData: [CountryTravelModel]?
    
    private static var amadeus: Amadeus?
    
    static func loadData(country: String, type: TripViewType? = nil, completion: @escaping (_ finished: Bool) -> Void){
        FirebaseManager.fetchCredentials(type: .amadeus){ credential in
            amadeus = Amadeus(client_id: credential.0, client_secret: credential.1)
            
            let iso3Country = countryToISO(country: country, dictionary: roISOCountries)
            let iso2Country = ISO3ToISO2[iso3Country!]
            
            amadeus!.client.get(path: "/v2/duty-of-care/diseases/covid19-area-report",
                              params: ["countryCode" : iso2Country!],
                              onCompletion: { result in
               switch result {
               case .success(let response):
                   do {
                       let json = try response.data.rawData()
                       let data = try JSONDecoder().decode(TravelAdvice.self, from: json)
                       
                       let diseaseRiskLevel = CountryTravelModel(icon: "cross", title: "Risc de călătorie", subtitle: data.diseaseRiskLevel!.text!)
                       let diseaseInfection = CountryTravelModel(icon: "allergens", title: "Risc de îmbolnăvire", subtitle: data.diseaseInfection!.level!, text: "Rata de imbolnavire: \(data.diseaseInfection!.rate!)")
                       let areaPolicy = CountryTravelModel(icon: "exclamationmark.triangle", title: "Restricții", subtitle: data.areaPolicy!.status!, text: data.areaPolicy!.text!)
                       let entry = CountryTravelModel(icon: "arrow.forward.square", title: "Reguli de intrare în țară", subtitle: data.areaAccessRestriction!.entry!.ban!, text: data.areaAccessRestriction!.entry!.text!)
                       let quarantine = CountryTravelModel(icon: "pills", title: "Carantină necesară", subtitle: data.areaAccessRestriction!.travelQuarantineModality!.eligiblePerson!)
                       let vaccination = CountryTravelModel(icon: "bandage", title: "Vaccinare necesară", subtitle: data.areaAccessRestriction!.travelVaccination!.isRequired!, text:  data.areaAccessRestriction!.travelVaccination!.details!)
                       let testing = CountryTravelModel(icon: "heart.text.square", title: "Testare necesară", subtitle: data.areaAccessRestriction!.travelTest!.isRequired!)
                       let mask = CountryTravelModel(icon: "facemask", title: "Mască necesară", subtitle: data.areaAccessRestriction!.masks!.isRequired!, text: data.areaAccessRestriction!.masks!.text!)
                       
                       if let type = type {
                           switch type {
                           case .arrival:
                               AmadeusManager.arrivalCountryTravelData = [diseaseRiskLevel, diseaseInfection, areaPolicy, entry, quarantine, vaccination, testing, mask]
                           case .departure:
                               AmadeusManager.departureCountryTravelData = [diseaseRiskLevel, diseaseInfection, areaPolicy, entry, quarantine, vaccination, testing, mask]
                           }
                       } else {
                           AmadeusManager.currentCountryTravelData = [diseaseRiskLevel, diseaseInfection, areaPolicy, entry, quarantine, vaccination, testing, mask]
                       }

                       print("Amadeus Manager loaded data!")
                       completion(true)
                   } catch {
                       print(error)
                       delegates.onboardingDownload.dataError()
                       completion(false)
                   }
               case .failure(let error):
                   print(error)
                   delegates.onboardingDownload.dataError()
                   completion(false)
               }
            })
        }
    }
}

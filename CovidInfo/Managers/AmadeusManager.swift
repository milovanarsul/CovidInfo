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
    
    private static let clientID = "0A9ULICFLK0XG4oGirzZTG0pHHt29ogq"
    private static let clientSecret = "MUVA5zG1u02YxPO4"
    
    private static let amadeus: Amadeus = Amadeus(client_id: clientID, client_secret: clientSecret)
    
    static func loadData(country: String, type: TripViewType? = nil, completion: @escaping (_ finished: Bool) -> Void){
        let iso3Country = countryToISO(country: country, dictionary: roISOCountries)
        let iso2Country = ISO3ToISO2[iso3Country!]
        
        amadeus.client.get(path: "/v1/duty-of-care/diseases/covid19-area-report",
                          params: ["countryCode" : iso2Country!],
                          onCompletion: {  result in
           switch result {
           case .success(let response):
               do {
                   let json = try response.data.rawData()
                   let data = try JSONDecoder().decode(TravelAdvice.self, from: json)
                   
                   let diseaseRiskLevel = CountryTravelModel(icon: "cross", title: "Risc de calatorie", subtitle: data.diseaseRiskLevel!)
                   let diseaseInfection = CountryTravelModel(icon: "allergens", title: "Risc de imbolnavire", subtitle: data.diseaseInfection!.level!, text: "Rata de imbolnavire: \(data.diseaseInfection!.rate!)")
                   let areaPolicy = CountryTravelModel(icon: "exclamationmark.triangle", title: "Restrictii", subtitle: data.areaPolicy!.status!, text: data.areaPolicy!.text!)
                   let entry = CountryTravelModel(icon: "arrow.forward.square", title: "Reguli de intrare in tara", subtitle: data.areaAccessRestriction!.entry!.ban!, text: data.areaAccessRestriction!.entry!.text!)
                   let quarantine = CountryTravelModel(icon: "pills", title: "Carantina necesara", subtitle: data.areaAccessRestriction!.quarantineModality!.eligiblePerson!)
                   let vaccination = CountryTravelModel(icon: "bandage", title: "Vaccinare necesara", subtitle: data.areaAccessRestriction!.diseaseVaccination!.isRequired!, text:  data.areaAccessRestriction!.diseaseVaccination!.text!)
                   let testing = CountryTravelModel(icon: "heart.text.square", title: "Testare necesara", subtitle: data.areaAccessRestriction!.diseaseTesting!.isRequired!)
                   let mask = CountryTravelModel(icon: "facemask", title: "Masca necesara", subtitle: data.areaAccessRestriction!.mask!.isRequired!, text: data.areaAccessRestriction!.mask!.text!)
                   
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
                   completion(false)
               }
           case .failure(let error):
               print(error)
               completion(false)
           }
        })
    }
}

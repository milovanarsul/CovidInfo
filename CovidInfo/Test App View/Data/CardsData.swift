//
//  CardsData.swift
//  appstoreclone
//
//  Created by Andrei Blaj on 10/6/20.
//

import UIKit

class CardsData {
    
    static let instance = CardsData()
    
    class var shared: CardsData {
        return instance
    }
    
    let json: [String: Any]
    
    var cards: [Article] {
        return parseCards(forJSON: json)
    }
    
    init() {
        guard let cardsURL = Bundle.main.url(forResource: "CardsData", withExtension: "json") else {
            json = [:]
            return
        }
        
        do {
            let cardsData = try Data(contentsOf: cardsURL)
            if let cardsJson = try JSONSerialization.jsonObject(with: cardsData, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                json = cardsJson
            } else {
                json = [:]
                print("[LOG] Error parsing CardsData.json data")
            }
        } catch {
            json = [:]
            print("[LOG] Error parsing .json data")
        }
    }
    
    // MARK: - Parse Cards -
    func parseCards(forJSON json: [String: Any]) -> [Article] {
        guard let cardsData = json["cardTiles"] as? [[String: Any]] else { return [] }
        
        let cards = cardsData.compactMap({ (cardsDictionary) -> Article? in
            
            guard let cardTypeString = cardsDictionary["type"] as? String else { return nil }
          
            let bgImageString = cardsDictionary["backgroundImage"] as? String
            let bgTypeString = cardsDictionary["backgroundType"] as? String
            let bgType = BackgroundType(rawValue: bgTypeString ?? "")
            let title = cardsDictionary["title"] as? String
            let subtitle = cardsDictionary["subtitle"] as? String
            let description = cardsDictionary["description"] as? String
          
            switch cardTypeString {
            case "appArticle":
                guard let bgImage = UIImage(named: bgImageString ?? "card1"),
                    let title = title,
                    let subtitle = subtitle,
                    let description = description else { break }
                
                let cardType = Article(backgroundImage: bgImage, backgroundType: bgType!, title: title, subtitle: subtitle, description: description)
                return cardType
            default:
                return nil
          }
          
          return nil
        })
        return cards
    }
}

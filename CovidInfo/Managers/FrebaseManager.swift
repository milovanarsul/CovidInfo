//
//  FBManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.06.2022.
//

import Foundation
import Firebase

class FirebaseManager {
    static var databaseReference = Database.database().reference()
    static var storageReference = Storage.storage().reference()
    
    static var faqData = [InfoCardsData]()
    static var vaccinationData = [InfoCardsData]()
    static var variantsData = [Article]()
    
    static func loadData(){
        fetchInfoCardsData(infoCardsType: .intrebariFrecvente)
        fetchInfoCardsData(infoCardsType: .vaccinare)
        fetchVariantsData()
    }
    
    static func storageJSONURLS(type: DataType, filesNumber: Int) -> [String]{
        var downloadURLS = [String]()
        var jsonParentPath = ""
        
        switch type {
        case .preventie:
            jsonParentPath = "Preventie/preventie"
        case .simptome:
            jsonParentPath = "Simptome/simptome"
        }
        
        for jsonIndex in 0...filesNumber{
            storageReference.child(jsonParentPath + String(jsonIndex) + ".json").downloadURL(completion: { url, error in
                guard let url = url, error == nil else {return}
                
                let urlString = url.absoluteString
                downloadURLS.append(urlString)
            })
        }
        
        return downloadURLS
    }
    
    static func storageDownloadJSONS(type: DataType, filesNumber: Int){
        let jsonURLS = storageJSONURLS(type: type, filesNumber: filesNumber)
        
        let session = URLSession.shared
        
        for index in 0...filesNumber {
            let url = URL(string: jsonURLS[index])!
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringCacheData
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
                guard let _:Data = data, let _:URLResponse = response, error == nil else {
                    return
                }
                
                var fileName = ""
                switch type {
                case .preventie:
                    fileName = "preventie"
                case .simptome:
                    fileName = "simptome"
                }
                
                saveDataToDisk(data: data!, fileName: fileName + String(index) + ".json")
            })
            task.resume()
        }
    }
    
    static func fetchVariantsData(){
        databaseReference.child("Variante").observe(.value) {(snapshot) in
            for variant in snapshot.children.allObjects as! [DataSnapshot]{
                let object = variant.value as? [String: AnyObject]
                let title = object?["title"] as! String
                let content = object?["content"] as! String
                let image = object?["image"] as! String
                
                let article = Article(context: AppDelegate.context)
                article.viewMode = .card
                article.backgroundType = .light
                article.isTrusted = false
                article.title = title
                article.link = nil
                article.backgroundImage = image
                article.articleDescription = content
                article.author = nil
                article.date = stringToDate(string: "01.01.1900 00:00")
                article.isVariant = true
                
                variantsData.append(article)
            }
        }
    }
    
    static func fetchInfoCardsData(infoCardsType: InfoCardsType){
        var childName: String?
        switch infoCardsType {
        case .intrebariFrecvente:
            childName = "IntrebariFrecvente"
        case .vaccinare:
            childName = "Vaccinare"
        }
        
        databaseReference.child(childName!).observe(.value) { (snaphshot) in
            for card in snaphshot.children.allObjects as! [DataSnapshot]{
                let object = card.value as? [String: AnyObject]
                let title = object?["title"] as! String
                let content = object?["content"] as! String
                
                switch infoCardsType {
                case .intrebariFrecvente:
                    self.faqData.append(InfoCardsData(title: title, content: content))
                case .vaccinare:
                    self.vaccinationData.append(InfoCardsData(title: title, content: content))
                }
            }
            
            switch infoCardsType {
            case .intrebariFrecvente:
                self.faqData.reverse()
            case .vaccinare:
                self.vaccinationData.reverse()
            }
        }
    }
    
    static func fetchCredentials(type: clientType, completion: @escaping (_ finished: (String, String)) -> Void){
        databaseReference.child(type.rawValue).observeSingleEvent(of: .value, with: { (snapshot) in
            let object = snapshot.value as? [String:AnyObject]
            let clientID = object?["clientID"] as! String
            let clientSecret = object?["clientSecret"] as! String
            
            completion((clientID, clientSecret))
        })
    }
}

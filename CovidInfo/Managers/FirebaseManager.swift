//
//  FirebaseManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 25.04.2022.
//

import Foundation
import Firebase

enum DataType{
    case preventie
    case simptome
}

class FirebaseManager{
    var databaseReference = Database.database().reference()
    var storageReference = Storage.storage().reference()
    
    init(){}
    
    func storageJSONURLS(type: DataType, filesNumber: Int) -> [String]{
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
    
    func storageDownloadJSONS(type: DataType, filesNumber: Int){
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
}


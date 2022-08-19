//
//  TranslatorManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.06.2022.
//

import Foundation

class TranslatorManager{
    
    static var headers: [String: String]?
    
    static var request = URLRequest(url: URL(string: "https://lingvanex-translate.p.rapidapi.com/translate")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    
    static func translate(text: String, completion: @escaping (String?) -> ()){
        FirebaseManager.fetchCredentials(type: .translateAPI){ credentials in
            headers = [
                "content-type": "application/json",
                "X-RapidAPI-Host": credentials.0,
                "X-RapidAPI-Key": credentials.1
            ]
            
            var parsedText = text.replacingOccurrences(of: "<p>", with: "")
            parsedText = parsedText.replacingOccurrences(of: "</p>", with: "")
            
            let parameters = [ "from": "en_GB", "to": "ro_RO",
                "data": parsedText,
                "platform": "api"
            ] as [String : Any]
            let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = headers
            request.httpBody = postData as Data
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print(error)
                } else {
                    let translation = try! JSONDecoder().decode(Translate.self, from: data!)
                    let translatedText = translation.result
                    completion(translatedText)
                }
            }.resume()
        }
    }
}

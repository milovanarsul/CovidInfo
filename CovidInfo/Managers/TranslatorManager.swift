//
//  TranslatorManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 01.06.2022.
//

import Foundation

class TranslatorManager{
    
    static let headers = [
        "content-type": "application/json",
        "X-RapidAPI-Host": "lingvanex-translate.p.rapidapi.com",
        "X-RapidAPI-Key": "6a4c817bd3msh1c8083caf2bbf07p1e7831jsnc8e777d0638d"
    ]
    
    static var request = URLRequest(url: URL(string: "https://lingvanex-translate.p.rapidapi.com/translate")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
    
    static func translate(text: String, completion: @escaping (String?) -> ()){
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
            if error != nil {
                completion(nil)
            } else {
                let translation = try! JSONDecoder().decode(Translate.self, from: data!)
                let translatedText = translation.result
                print("Translation successful!")
                completion(translatedText)
            }
        }.resume()
    }
}

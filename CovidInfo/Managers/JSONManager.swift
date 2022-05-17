//
//  JSONManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 17.05.2022.
//

import Foundation

func localJSONParser<T>(json: String, type: T.Type) -> T? where T : Decodable{
    do {
        if let bundlePath = Bundle.main.path(forResource: json, ofType: "json"),
           let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8){
            let decodedData = try JSONDecoder().decode(type.self, from: jsonData)
            return decodedData
        }
    } catch {
        print(error)
    }
    
    return nil
}

func onlineJSONParser<T>(json: String, type: T.Type) -> T? where T : Decodable {
    if let url = URL(string: json){
        if let data = try? Data(contentsOf: url){
            do{
                let decodedData = try JSONDecoder().decode(type.self, from: data)
                return decodedData
            } catch {
                print(error)
            }
        }
    }
    
    return nil
}

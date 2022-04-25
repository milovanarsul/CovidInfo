//
//  DiskManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 25.04.2022.
//

import Foundation
import Lottie

func saveDataToDisk(data: Data, fileName: String){
    do {
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentURL.appendingPathComponent(fileName)
        try data.write(to: fileURL, options: .atomic)
    } catch {
        print(error)
    }
}

func readDataFromDisk(fileName: String) -> Data? {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let filePath = documentURL.appendingPathComponent(fileName).path
    
    if FileManager.default.fileExists(atPath: filePath), let data = FileManager.default.contents(atPath: filePath){
        return data
    }
    
    return nil
}

func filePath(fileName: String) -> String? {
    let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let filePath = documentURL.appendingPathComponent(fileName).path
    
    if FileManager.default.fileExists(atPath: filePath){
        return filePath
    }
    
    return nil
}

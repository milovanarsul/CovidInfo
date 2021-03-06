//
//  LocalStorageManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.03.2022.
//

import Foundation
import UIKit

class LocalStorageManager{
    public func storeImage(image: UIImage, forKey key: String, withStorageType storageType: StorageStye) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do {
                        try pngRepresentation.write(to: filePath, options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            }
        }
    }
    
    public func retrieveImage(forKey key: String, inStorageType storageType: StorageStye) -> UIImage? {
        switch storageType {
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) { return image }
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        }
        
        return nil
    }
    
    public func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    public func save(image: UIImage, key: String, completion: @escaping (_ finished: Bool) -> Void){
        DispatchQueue.main.async {
            self.storeImage(image: image, forKey: key, withStorageType: .fileSystem)
            completion(true)
        }
    }
    
    public func display(key: String, imageView: UIImageView){
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: key, inStorageType: .fileSystem) {
                DispatchQueue.main.async {
                    imageView.image = savedImage
                }
            }
        }
    }
}

let localStorageManager = LocalStorageManager()

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

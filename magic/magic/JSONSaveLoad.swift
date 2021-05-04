//
//  Protocols.swift
//  magic
//
//  Created by José Manuel Romero Clavería on 30/4/21.
//

import Foundation

import UIKit

class LoadAndSave {
    static func loadJSON(file: String)throws -> Data? {
        let fileMan = FileManager.default
        let urls = fileMan.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            let fileURL = url.appendingPathComponent(file)
            // fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            // let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
            return data
        }
        
        return nil
    }
    
    static func saveJSON(data: Data, file: String, isFirst: Bool)throws -> Bool {
        let fileMan = FileManager.default
        let urls = fileMan.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            let fileURL = url.appendingPathComponent(file)
            if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
                if !isFirst {
                    print("escribo al final")
                    fileHandle.seekToEndOfFile()
                    fileHandle.write(data)
                } else {
                    try data.write(to: fileURL, options: [.atomicWrite])
                }
            }
            // fileURL = fileURL.appendingPathExtension("json")
            // let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            // try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        
        return false
    }
            
}

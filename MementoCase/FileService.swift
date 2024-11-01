//
//  FileService.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import Foundation

class FileService {
    static let shared = FileService()
    
    private init() {}
    
    func writeToFile(fileName: String, content: String) throws -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName).txt")
        
        do {
            try content.write(to: fileURL, atomically: true, encoding: .utf8)
            print("File written successfully to \(fileURL)")
            return fileURL
        } catch {
            print("Error writing file: \(error)")
            throw error
        }
    }
}


//
//  FileService.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import Foundation

final class FileService {
    @discardableResult
    func writeToFile(fileName: String, content: [String]) throws -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent("\(fileName)")

        let contentString = content.joined(separator: "\n")

        try contentString.write(to: fileURL, atomically: true, encoding: .utf8)
        print("File written successfully to \(fileURL)")
        return documentsDirectory
    }

    func readAllStrings(from fileURL: URL) throws -> [String]? {
        let content = try String(contentsOf: fileURL, encoding: .utf8)
        return content.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }

    func generateFilename() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd_HHmmss" // Format: YearMonthDay_HourMinuteSecond
        let timestamp = dateFormatter.string(from: Date())

        return "\(timestamp).txt" // Generates a filename like "20241101_134500.txt"
    }

    func clearFiles(at url: URL) throws {
        let fileManager = FileManager.default

        let files = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)

        for file in files {
            try fileManager.removeItem(at: file)
            print("Deleted file: \(file.lastPathComponent)")
        }

        print("All files cleared at \(url)")
    }
}

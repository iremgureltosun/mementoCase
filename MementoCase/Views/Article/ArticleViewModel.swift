//
//  ArticleViewModel.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//
import Observation
import OSLog
import Observation
import OSLog

@Observable
final class ArticleViewModel {
    @ObservationIgnored let logger = Logger()
    @ObservationIgnored private let fileService = FileService()
    @ObservationIgnored private let careTaker = CareTaker<FileNameMemento>()
    @ObservationIgnored private var documentDirectoryUrl: URL?
    
    var text: String = ""
    
    private func getText(from lines: [String]) -> String {
        lines.joined(separator: "\n")
    }
    
    private func getLines() -> [String] {
        let lines = text.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        return lines
    }
    
    func saveFile() throws {
        let fileName = fileService.generateFilename()
        let lines = getLines()
        
        documentDirectoryUrl = try fileService.writeToFile(fileName: fileName, content: lines)
        careTaker.save(memento: FileNameMemento(state: fileName))
    }

    func clearFiles() {
        guard let directoryUrl = documentDirectoryUrl else {
            logger.error("Document directory URL is nil. Cannot clear files.")
            return
        }
        
        do {
            try fileService.clearFiles(at: directoryUrl)
        } catch {
            logger.error("Error occurred when deleting files: \(error.localizedDescription)")
        }
        careTaker.clear()
        text = ""
    }

    func undo() {
        guard let lastMemento = careTaker.restore(), let path = documentDirectoryUrl else {
            print("No mementos left to undo.")
            return
        }
        
        let fileName = lastMemento.state
        let fileUrl = path.appendingPathComponent(fileName)
        do {
            let fileContent = try fileService.readAllStrings(from: fileUrl)
            let lines = fileContent ?? []
            text = getText(from: lines)
        } catch {
            logger.error("Error occurred when reading the file: \(error.localizedDescription)")
        }
    }

    func redo() {
        guard let lastMemento = careTaker.redo(), let path = documentDirectoryUrl else {
            print("No mementos left to redo.")
            return
        }
        
        let fileName = lastMemento.state
        let fileUrl = path.appendingPathComponent(fileName)
        do {
            let fileContent = try fileService.readAllStrings(from: fileUrl)
            let lines = fileContent ?? []
            text = getText(from: lines)
        } catch {
            logger.error("Error occurred when reading the file: \(error.localizedDescription)")
        }
    }
}

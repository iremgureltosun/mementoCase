//
//  ArticleViewModel.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import Observation
import OSLog

@Observable final class ArticleViewModel {
    @ObservationIgnored let logger = Logger()
    @ObservationIgnored private let fileService = FileService()
    // Caretaker to manage snapshots of the writing list
    @ObservationIgnored private let careTaker = CareTaker<FileNameMemento>()

    var documentDirectoryUrl: URL?

    var text: String = ""
    
    private func getText(from lines: [String]) -> String {
        lines.joined(separator: "\n")
    }
    
    private func getLines() ->  [String] {
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
        if let documentDirectoryUrl = documentDirectoryUrl {
            do {
                try fileService.clearFiles(at: documentDirectoryUrl)
            } catch {
                logger.error("Error occured when deleting files: \(error.localizedDescription)")
            }
        }
        careTaker.clear()
        text = ""
    }

    func undo() {
        if let lastMemento = careTaker.restore(), let path = documentDirectoryUrl {
            let fileName = lastMemento.state
            let fileUrl = path.appendingPathComponent(fileName)
            do {
                let fileContent = try fileService.readAllStrings(from: fileUrl)
                let lines = fileContent ?? []
                text = getText(from: lines)
            } catch {
                logger.error("Error occured when reading the file: \(error.localizedDescription)")
            }
        } else {
            print("not left")
        }
    }

    func redo() {
        if let lastMemento = careTaker.redo(), let path = documentDirectoryUrl {
            let fileName = lastMemento.state
            let fileUrl = path.appendingPathComponent(fileName)
            do {
                let fileContent = try fileService.readAllStrings(from: fileUrl)
                let lines = fileContent ?? []
                text = getText(from: lines)
            } catch {
                logger.error("Error occured when reading the file: \(error.localizedDescription)")
            }
        }
    }

}

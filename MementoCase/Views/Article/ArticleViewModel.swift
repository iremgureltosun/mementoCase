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

    var lines: [String] = []

    // Computed property to get and set lines as a single string
    var text: String {
        get {
            lines.joined(separator: "\n")
        }
        set {
            lines = newValue.components(separatedBy: "\n")
        }
    }

    func saveFile() throws {
        let fileName = fileService.generateFilename()
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
    }

//    func undo() {
//        let lastMemento = careTaker.restore()
//        if lastMemento == nil {
//            drawings = []
//        } else {
//            updateList()
//        }
//    }
//
//    func redo() {
//        _ = careTaker.redo()
//        updateList()
//    }
//
}

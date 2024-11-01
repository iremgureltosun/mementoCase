//
//  PaintViewModel.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import Observation

@Observable final class PaintViewModel {
    private(set) var drawings: [Drawing] = []
    var newDrawing: Drawing?

    // Caretaker to manage snapshots of the drawing list
    let careTaker = CareTaker<DrawingMemento>()

    // Function to add a new drawing and save the current state as a memento
    func addDrawing(_ drawing: Drawing) {
        drawings.append(drawing)
        careTaker.save(memento: DrawingMemento(state: drawings))
    }

    func undo() {
        let lastMemento = careTaker.restore()
        if lastMemento == nil {
            drawings = []
        } else {
            updateList()
        }
    }

    func redo() {
        _ = careTaker.redo()
        updateList()
    }

    // Reset the drawing list and clear the history
    func clearDrawings() {
        drawings = []
        careTaker.clear()
    }

    private func updateList() {
        if let currentMemento = careTaker.current() {
            drawings = currentMemento.state
        }
    }
}

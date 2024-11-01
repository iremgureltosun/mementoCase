//
//  CareTaker.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

class CareTaker<T: MementoProtocol> {
    private(set) var mementos: [T] = []
    var currentIndex: Int = -1 // Start with no mementos

    // Save a new memento to the history
    func save(memento: T) {
        // Remove any mementos after the current index to maintain history
        if currentIndex < mementos.count - 1 {
            mementos.removeLast(mementos.count - 1 - currentIndex)
        }

        mementos.append(memento)
        currentIndex += 1 // Move the index forward
    }

    // Restore the last saved state
    func restore() -> T? {
        guard currentIndex >= 0 else { return nil }
        let memento = mementos[currentIndex]
        currentIndex -= 1 // Move the index back for undo
        return memento
    }

    // Redo the last undone state
    func redo() -> T? {
        guard currentIndex + 1 < mementos.count else { return nil }
        currentIndex += 1 // Move the index forward for redo
        return mementos[currentIndex]
    }

    // Clear all saved states
    func clear() {
        mementos.removeAll()
        currentIndex = -1 // Reset the index
    }

    func current() -> T? {
        guard currentIndex >= 0 else { return nil }
        return mementos[currentIndex]
    }
}

//
//  Originator.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

protocol OriginatorProtocol {
    associatedtype State
    
    func createMemento() -> any MementoProtocol
    func restore(from memento: any MementoProtocol)
}

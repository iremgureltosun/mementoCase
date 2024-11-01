//
//  Memento.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

protocol MementoProtocol {
    associatedtype StateType: Equatable
    var state: StateType { get }
}

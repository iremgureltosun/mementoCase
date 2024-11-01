//
//  DrawingMemento.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import Foundation
import SwiftUI

struct DrawingMemento: MementoProtocol {
    let state: [Drawing]
}

struct Drawing: Identifiable, Equatable {
    var id = UUID()
    var path: Path
    var color: Color
    var lineWidth: CGFloat
}

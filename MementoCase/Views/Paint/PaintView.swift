//
//  PaintView.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//
import SwiftUI

struct PaintView: View {
    @State private var viewModel = PaintViewModel()

    @State private var currentPath: Path = Path()

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to drawing board. Feel free to draw what you want.")
                Canvas { context, _ in
                    // Draw all paths stored in drawings
                    for drawing in viewModel.drawings {
                        context.stroke(drawing.path, with: .color(drawing.color), lineWidth: drawing.lineWidth)
                    }

                    context.stroke(currentPath, with: .color(.black), lineWidth: 2)
                }
                .gesture(
                    DragGesture(minimumDistance: 0.1)
                        .onChanged { value in
                            let point = value.location
                            currentPath.addLine(to: point)
                        }
                        .onEnded { _ in
                            viewModel.addDrawing(Drawing(path: currentPath, color: .black, lineWidth: 2))
                            // Reset 'currentPath' for the next drawing
                            currentPath = Path()
                        }
                )

                HStack {
                    // Clear button
                    Button(action: {
                        viewModel.clearDrawings()
                    }) {
                        Text("Clear")
                            .customButtonStyle()
                    }

                    // Undo button
                    Button(action: {
                        viewModel.undo()
                    }) {
                        Text("Undo")
                            .customButtonStyle()
                    }

                    // Redo button
                    Button(action: {
                        viewModel.redo()
                    }) {
                        Text("Redo")
                            .customButtonStyle()
                    }
                }
                .padding()
            }
            .navigationBarTitle("Drawing Board")
        }
    }
}

#Preview {
    PaintView()
}

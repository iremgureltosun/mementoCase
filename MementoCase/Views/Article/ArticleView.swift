//
//  ArticleView.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import OSLog
import SwiftUI

struct ArticleView: View {
    @State private var viewModel = ArticleViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Article Generator")
                .font(.title)

            TextEditor(text: $viewModel.text)
                .padding(.horizontal, 36)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )

            HStack(spacing: 20) {
                saveButton

                clearFilesButton

                Spacer()

                undoButton

                redoButton
            }
            .padding(.bottom, 20)
            Divider()
        }
        .padding(.horizontal, 20)
    }

    @ViewBuilder private var saveButton: some View {
        Button {
            do {
                try viewModel.saveFile()
            } catch {
                viewModel.logger.error("Error occured: \(error.localizedDescription)")
            }
        } label: {
            Text("Save")
        }
    }

    @ViewBuilder private var clearFilesButton: some View {
        Button {
            viewModel.clearFiles()
        } label: {
            Text("Clear All")
        }
    }

    @ViewBuilder private var undoButton: some View {
        Button {
            viewModel.undo()
        } label: {
            Text("Undo")
        }
    }
    
    @ViewBuilder private var redoButton: some View {
        Button {
            viewModel.redo()
        } label: {
            Text("Redo")
        }
    }
}

#Preview {
    ArticleView()
}

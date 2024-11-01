//
//  ArticleView.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import SwiftUI
import OSLog

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
              
            
            HStack (spacing: 20) {
                Button {
                    do {
                        try viewModel.saveFile()
                    }
                    catch {
                        viewModel.logger.error("Error occured: \(error.localizedDescription)")
                    }
                } label: {
                    Text("Save")
                }
                
                Button {
                    viewModel.clearFiles()
                } label: {
                    Text("Clear All")
                }
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text("Undo")
                }
                Button {
                    
                } label: {
                    Text("Redo")
                }

            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    ArticleView()
}

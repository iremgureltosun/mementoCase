//
//  ArticleView.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import SwiftUI

struct ArticleView: View {
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Article Generator")
                .font(.title)
            
            TextEditor(text: $inputText)
                .padding(.horizontal, 36)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
              
            
            HStack (spacing: 20) {
                Button {
                    
                } label: {
                    Text("Save")
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

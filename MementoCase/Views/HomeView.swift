//
//  HomeView.swift
//  MementoCase
//
//  Created by İrem Tosun on 31.10.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            PaintView()
                .tabItem {
                    Label("Paint", systemImage: "1.circle")
                }

            ArticleView()
                .tabItem {
                    Label("Article", systemImage: "2.circle")
                }
        }
    }
}

#Preview {
    HomeView()
}

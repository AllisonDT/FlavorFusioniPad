//
//  ListTabView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct ListTabView: View {
    @State private var tabSelection = 0
    
    var body: some View {
        TabView(selection: $tabSelection) {
            List()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
                
            RecipeBookView()
                .tabItem {
                    Label("Recipe Book", systemImage: "book")
                }
                .tag(1)
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(1)
            
            AboutView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(2)
        }
        .id(tabSelection)
    }
}

#Preview {
    ListTabView()
}

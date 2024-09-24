//
//  ListTabView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

/// A view that provides a tabbed interface for the main sections of the app.
///
/// `ListTabView` displays a tab bar with four tabs: Home, Recipe Book, Settings, and About.
/// Each tab presents a different view when selected.
///
/// - Parameters:
///   - tabSelection: A state variable that tracks the selected tab.
struct ListTabView: View {
    @State private var tabSelection = 0
    @StateObject private var spiceDataViewModel = SpiceDataViewModel() // Create the view model here

    var body: some View {
        TabView(selection: $tabSelection) {
            List() // Assuming this is a placeholder for a real view
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)
                
            RecipeList(spiceDataViewModel: spiceDataViewModel) // Pass the view model
                .tabItem {
                    Label("Recipe Book", systemImage: "book")
                }
                .tag(1)
            
            SettingsView() // Assuming SettingsView doesn't need SpiceDataViewModel
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(2)
            
            AboutView() // Assuming AboutView doesn't need SpiceDataViewModel
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
                .tag(3)
        }
        .id(tabSelection)
    }
}

#Preview {
    ListTabView()
}

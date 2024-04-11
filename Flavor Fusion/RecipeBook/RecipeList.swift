//
//  RecipeList.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

// This struct represents the list of recipes view.
struct RecipeList: View {
    // Creating a shared instance of RecipeStore for managing recipes.
    static let sharedRecipeStore = RecipeStore()
    
    // State variables for managing search text and add recipe view presentation.
    @State private var searchText: String = ""
    @State private var isAddRecipeViewPresented = false
    
    // Computed property for filtering spices based on search text.
    var filteredSpices: [Spice] {
        if searchText.isEmpty {
            return spicesData
        } else {
            return spicesData.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        NavigationView {
            ScrollView {
                HStack {
                    Spacer()
                    // Displaying the search bar
                    SearchBar(searchText: $searchText)
                    // Button for filters (not implemented)
                    FiltersButton()
                    // Button for adding a new recipe
                    Button(action: {
                        isAddRecipeViewPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                VStack(spacing: 20) {
                    // Displaying each recipe in a list
                    ForEach(RecipeList.sharedRecipeStore.recipes) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                }
                .padding()
            }
        }
        // Presenting the AddRecipeView as a sheet
        .sheet(isPresented: $isAddRecipeViewPresented) {
            AddRecipeView(isPresented: $isAddRecipeViewPresented)
        }
    }
}

// This struct represents the filters button (not implemented).
struct FiltersButton: View {
    var body: some View {
        Button(action: {
            // Action for Filters Button
        }) {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.system(size: 24))
                .padding()
        }
    }
}

// This struct represents the add button (not implemented).
struct AddButton: View {
    var body: some View {
        Button(action: {
            // Action for Add Button
        }) {
            Image(systemName: "plus.circle")
                .font(.system(size: 24))
                .padding()
        }
    }
}

// This struct represents the row view for displaying a recipe.
struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text("Servings: \(recipe.servings)")
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Button for navigating to recipe details (not implemented)
            Button(action: {
                // Action for the green "go" button
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

// Preview Provider for the RecipeList view
struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeList()
    }
}

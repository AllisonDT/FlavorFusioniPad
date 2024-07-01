//
//  RecipeList.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

// This struct represents the list of recipes view.
struct RecipeList: View {
    @ObservedObject var recipeStore = RecipeStore()
    
    // State variables for managing search text and add recipe view presentation.
    @State private var searchText: String = ""
    @State private var isAddRecipeViewPresented = false
    
    // Computed property for filtering recipes based on search text.
    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipeStore.recipes
        } else {
            return recipeStore.recipes.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
                    ForEach(filteredRecipes) { recipe in
                        RecipeRow(recipe: recipe, recipeStore: recipeStore)
                    }
                }
                .padding()
            }
        }
        // Presenting the AddRecipeView as a sheet
        .sheet(isPresented: $isAddRecipeViewPresented) {
            // Pass the recipe store to the AddRecipeView
            AddRecipeView(isPresented: $isAddRecipeViewPresented, recipeStore: recipeStore)
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

// This struct represents the row view for displaying a recipe.
struct RecipeRow: View {
    var recipe: Recipe
    var recipeStore: RecipeStore
    @State private var isMixPreviewPresented = false

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)
                Text("Servings: \(recipe.servings)")
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Button to trigger the MixRecipePreview view
            Button(action: {
                isMixPreviewPresented.toggle()
            }) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.title)
                    .foregroundColor(.green)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
        .contextMenu {
            Button(action: {
                recipeStore.removeRecipe(recipe)
            }) {
                Text("Delete")
                Image(systemName: "trash")
            }
        }
        // Presenting the MixRecipePreview as a sheet
        .sheet(isPresented: $isMixPreviewPresented) {
            MixRecipePreview(recipe: recipe, isPresented: $isMixPreviewPresented)
        }
    }
}


// Preview Provider for the RecipeList view
struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeList()
    }
}

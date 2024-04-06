//
//  RecipeList.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

struct RecipeList: View {
    // Create a shared instance of RecipeStore
    static let sharedRecipeStore = RecipeStore()
    
    @State private var searchText: String = ""
    @State private var isAddRecipeViewPresented = false
    
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
                    SearchBar(searchText: $searchText)
                    FiltersButton()
                    Button(action: {
                        isAddRecipeViewPresented.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .padding()
                    }
                }
                VStack(spacing: 20) {
                    ForEach(RecipeList.sharedRecipeStore.recipes) { recipe in
                        RecipeRow(recipe: recipe)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isAddRecipeViewPresented) {
            AddRecipeView(isPresented: $isAddRecipeViewPresented)
        }
    }

    private func deleteRecipe(at offsets: IndexSet) {
        offsets.forEach { index in
            let recipe = RecipeList.sharedRecipeStore.recipes[index]
            RecipeList.sharedRecipeStore.removeRecipe(recipe)
        }
    }
}

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



struct RecipeList_Previews: PreviewProvider {
    static var previews: some View {
        return RecipeList()
    }
}

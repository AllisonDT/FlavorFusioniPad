//
//  RecipeList.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

struct RecipeList: View {
    @ObservedObject var recipeStore: RecipeStore

    init(recipeStore: RecipeStore) {
        self.recipeStore = recipeStore
    }

    var body: some View {
        NavigationView {
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.title)
                .padding(.bottom)
            Text("Ingredients:")
                .font(.headline)
            ForEach(recipe.ingredients, id: \.self) { ingredient in
                Text(ingredient)
            }
        }
        .padding()
    }
}

#Preview {
    let recipeStore = RecipeStore() // Initialize RecipeStore
    return RecipeList(recipeStore: recipeStore) // Pass RecipeStore to RecipeList
}

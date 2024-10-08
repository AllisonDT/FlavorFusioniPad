//
//  RecipeRow.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 10/8/24.
//

import SwiftUI

/// A view that displays a row representing a recipe with options to edit or delete.
///
/// `RecipeRow` shows the recipe's name, the number of servings, and provides buttons to either edit the recipe or delete it from the `RecipeStore`. It includes a confirmation alert before deleting a recipe.
///
/// - Parameters:
///   - recipe: The recipe being displayed in the row.
///   - recipeStore: The store that manages the collection of recipes.
///   - spiceDataViewModel: An observed object that manages spice data used across the app.
struct RecipeRow: View {
    var recipe: Recipe
    var recipeStore: RecipeStore
    @ObservedObject var spiceDataViewModel: SpiceDataViewModel

    @State private var isMixPreviewPresented = false
    @State private var isDeleteAlertPresented = false
    @State private var isEditRecipeViewPresented = false

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.blue)

                Text("Servings: \(recipe.servings)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()

            Spacer()

            Button(action: {
                isEditRecipeViewPresented.toggle()
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            .padding()
            .sheet(isPresented: $isEditRecipeViewPresented) {
                EditRecipeView(isPresented: $isEditRecipeViewPresented, recipeStore: recipeStore, recipe: recipe)
            }

            Button(action: {
                isDeleteAlertPresented = true
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .padding()
            .alert(isPresented: $isDeleteAlertPresented) {
                Alert(
                    title: Text("Delete Recipe"),
                    message: Text("Are you sure you want to delete this recipe?"),
                    primaryButton: .destructive(Text("Delete")) {
                        recipeStore.removeRecipe(recipe)
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemBackground))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .padding(.vertical, 4)
    }
}


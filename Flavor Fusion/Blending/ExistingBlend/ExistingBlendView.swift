//
//  ExistingBlendView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 5/11/24.
//

import SwiftUI

/// A view that displays a list of existing recipes and allows the user to select one.
///
/// `ExistingBlendView` provides a scrollable list of recipes. When a recipe is tapped,
/// it presents a detailed view of the selected recipe in a popover.
///
/// - Parameters:
///   - recipeStore: An observed object that manages the list of recipes.
struct ExistingBlendView: View {
    /// The currently selected recipe.
    @State private var selectedRecipe: Recipe?
    
    /// A flag indicating whether the recipe details popover is presented.
    @State private var isRecipeDetailsPresented = false
    
    /// The store object that manages the list of recipes.
    @ObservedObject var recipeStore = RecipeStore()
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // Display each recipe in a VStack
                    ForEach(recipeStore.recipes) { recipe in
                        ExistingRecipesRows(recipe: recipe)
                            .onTapGesture {
                                // Set the selected recipe when a recipe is tapped
                                self.selectedRecipe = recipe
                                self.isRecipeDetailsPresented = true
                            }
                    }
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    ExistingBlendView(recipeStore: RecipeStore())
}

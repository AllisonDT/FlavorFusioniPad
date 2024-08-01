//
//  ExistingBlendView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 5/11/24.
//

import SwiftUI

struct ExistingBlendView: View {
    // Properties
    @State private var selectedRecipe: Recipe?
    @State private var isRecipeDetailsPresented = false
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
            .navigationBarTitle("Select Recipe", displayMode: .inline)
            .popover(isPresented: $isRecipeDetailsPresented) {
                if let recipe = selectedRecipe {
                    RecipeDetails(recipe: recipe, isPresented: $isRecipeDetailsPresented)
                }
            }
        }
    }
}

// Recipe details view
struct RecipeDetails: View {
    var recipe: Recipe
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
                Button(action: {
                    // Dismiss the popover
                    self.isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
                .padding()
            }
            
            Text("Selected Recipe:")
                .font(.headline)
            
            Text("Name: \(recipe.name)")
            Text("Servings: \(recipe.servings)")
            
            Spacer()
            
            // Button to send the selected recipe to Arduino (replace with actual action)
            Button(action: {
                // Implement the action to send the selected recipe to Arduino
                print("Sending \(recipe.name) to Arduino...")
                // Dismiss the popover
                self.isPresented = false
            }) {
                Text("Mix Recipe!")
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.secondary.opacity(0.1))
        .cornerRadius(10)
    }
}

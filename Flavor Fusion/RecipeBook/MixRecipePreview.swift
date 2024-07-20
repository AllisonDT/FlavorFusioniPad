//
//  MixRecipePreview.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/1/24.
//

import SwiftUI

struct MixRecipePreview: View {
    var recipe: Recipe
    @Binding var isPresented: Bool
    @State private var isBlendConfirmationViewPresented = false
    @State private var showBlending = false
    @State private var showCompletion = false

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(recipe.name)
                .font(.largeTitle)
                .bold()
            
            Text("Servings: \(recipe.servings)")
                .font(.title2)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            
            Text("Ingredients:")
                .font(.title2)
                .bold()
            ForEach(recipe.ingredients, id: \.name) { ingredient in
                Text("\(ingredient.name): \(ingredient.amount)")
                    .font(.body)
                    .padding(.leading, 10)
            }
            
            Spacer()

            // Blend button at the bottom
            HStack {
                Spacer()
                Button(action: {
                    isBlendConfirmationViewPresented.toggle()
                }) {
                    Text("Blend")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                .padding()
                Spacer()
            }
        }
        .padding()
        .sheet(isPresented: $isBlendConfirmationViewPresented) {
            BlendConfirmationView(
                spiceName: recipe.name,
                servings: recipe.servings,
                ingredients: recipe.ingredients.map { $0.name },
                onConfirm: {
                    isBlendConfirmationViewPresented = false
                    showBlending = true
                }
            )
        }
        .sheet(isPresented: $showBlending) {
            BlendingView(onComplete: {
                showBlending = false
                showCompletion = true
            })
        }
        .sheet(isPresented: $showCompletion) {
            BlendCompletionView(onDone: {
                // Navigate back to home page logic here
                showCompletion = false
                isPresented = false
            })
        }
    }
}

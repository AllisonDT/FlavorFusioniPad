//
//  SpicePopupView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpicePopupView: View {
    let spice: Spice
    let recipes: [Recipe]
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            SpiceIndicator(amount: spice.spiceAmount, isSelected: true)
                .padding(.bottom, 10)
            
            Text("Spice: \(spice.name)")
                .font(.title2)
                .padding(.bottom, 5)
            
            Text("Container Number: \(spice.containerNumber)")
                .font(.subheadline)
                .padding(.bottom, 10)
            
            Divider()
                .padding(.vertical, 10)
            
            Text("Recipes:")
                .font(.headline)
                .padding(.bottom, 5)
            
            ForEach(recipes.filter { recipe in
                recipe.ingredients.contains { ingredient in
                    ingredient.name == spice.name
                }
            }) { recipe in
                Text(recipe.name)
                    .padding(.bottom, 2)
            }
            
            Button(action: {
                isPresented = false
            }) {
                Text("Close")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .padding(.top, 20)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal, 20)
    }
}

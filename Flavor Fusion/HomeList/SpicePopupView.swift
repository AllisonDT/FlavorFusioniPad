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
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    SpiceIndicator(amount: spice.spiceAmount, isSelected: true)
                        .padding(.trailing, 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Spice: \(spice.name)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.primary)
                        
                        Text("Container Number: \(spice.containerNumber)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Divider()
                    .padding(.vertical, 10)
                
                Text("Recipes:")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(recipes.filter { recipe in
                        recipe.ingredients.contains { ingredient in
                            ingredient.name == spice.name
                        }
                    }) { recipe in
                        Text(recipe.name)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                HStack {
                    Spacer()
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
                    .padding(.horizontal)
                    Spacer()
                }
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Spice Details", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented = false
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.primary)
            })
        }
    }
}

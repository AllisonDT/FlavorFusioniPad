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
        }
    }
}

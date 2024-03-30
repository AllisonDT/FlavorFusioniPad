////
////  RecipeDetail.swift
////  Flavor Fusion
////
////  Created by Allison Turner on 2/21/24.
////
//
//import SwiftUI
//
//// Define the RecipeDetail view to display details of a spice mix recipe
//struct RecipeDetail: View {
//    let recipe: SpiceMixRecipe
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 16) {
//            Text(recipe.name)
//                .font(.title)
//            Text("Ingredients:")
//                .font(.headline)
//            ForEach(recipe.ingredients, id: \.self) { ingredient in
//                Text("• \(ingredient)")
//            }
//            Text("Instructions:")
//                .font(.headline)
//            Text(recipe.instructions)
//        }
//        .padding()
//        .navigationTitle(recipe.name)
//    }
//}

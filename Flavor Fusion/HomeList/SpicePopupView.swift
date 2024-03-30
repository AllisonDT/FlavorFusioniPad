//
//  SpicePopupView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpicePopupView: View {
    let spice: Spice
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            SpiceIndicator(amount: spice.spiceAmount, isSelected: true) // Assuming isSelected should be true
            Text("Spice: \(spice.name)")
            Text("Container Number: \(spice.containerNumber)")
            Divider()
            Text("Recipes:")
                .font(.headline)
//            List {
//                ForEach(findRecipes(using: spice.name)) { recipe in
//                    Text(recipe.name)
//                }
//            }
            Button("Close") {
                isPresented = false
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
    }

    func findRecipes(using spiceName: String) -> [Recipe] {
        // Implement your searching algorithm here
        // For example, you might search through a recipe storage for recipes containing the spice name
        // Replace this with your actual implementation
        return []
    }
}

//#Preview {
//    SpicePopupView(spice: Spice, isPresented: Binding<Bool>)
//}

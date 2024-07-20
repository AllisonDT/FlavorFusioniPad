//
//  BlendConfirmationView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/13/24.
//

import SwiftUI

/// A view that displays the spice blend confirmation details and a confirm button.
///
/// `BlendConfirmationView` shows the blend name, the number of servings, and the list of ingredients specified by the user.
/// Below the details, a "Confirm" button allows the user to proceed with the blending process.
///
/// - Parameters:
///   - spiceName: The name of the spice blend provided by the user.
///   - servings: The number of servings selected by the user.
///   - ingredients: The list of ingredients to be included in the blend.
///   - onConfirm: A closure that is called when the "Confirm" button is pressed.
struct BlendConfirmationView: View {
    let spiceName: String
    let servings: Int
    let ingredients: [String]
    let onConfirm: () -> Void

    var body: some View {
        VStack {
            Text("Blend Created")
                .font(.largeTitle)
                .padding(.top)

            Text("Spice Name: \(spiceName)")
                .font(.title2)
                .padding(.top)

            Text("Servings: \(servings)")
                .font(.title2)
                .padding(.top)

            Text("Ingredients:")
                .font(.title2)
                .padding(.top)
            
            ForEach(ingredients, id: \.self) { ingredient in
                Text(ingredient)
                    .font(.body)
                    .padding(.top, 2)
            }

            Spacer()

            Button(action: onConfirm) {
                Text("Confirm")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    BlendConfirmationView(spiceName: "Example Spice", servings: 1, ingredients: ["Salt", "Pepper", "Garlic Powder"], onConfirm: {})
}

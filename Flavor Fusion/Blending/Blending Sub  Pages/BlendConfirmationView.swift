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

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Blend Created")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Group {
                        Text("Spice Name")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text(spiceName)
                            .font(.title2)
                            .padding(.bottom)
                        
                        Text("Servings")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        Text("\(servings)")
                            .font(.title2)
                            .padding(.bottom)
                        
                        Text("Ingredients")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(ingredients, id: \.self) { ingredient in
                            Text(ingredient)
                                .font(.body)
                                .padding(.leading, 10)
                        }
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button(action: onConfirm) {
                            Text("Confirm")
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
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    BlendConfirmationView(spiceName: "Example Spice", servings: 1, ingredients: ["Salt", "Pepper", "Garlic Powder"], onConfirm: {})
}

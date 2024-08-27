//
//  NewBlendView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

/// Enum to handle different alert types
enum BlendAlertType {
    case incompleteBlend
    case saveToRecipeBook
    case duplicateBlendName
}

/// A view for creating a new spice blend.
///
/// `NewBlendView` allows users to enter a spice blend name, select the number of servings,
/// and choose ingredients from a list. It includes a button to start the blending process,
/// which triggers a sequence of views for confirmation, blending, and completion.
///
/// - Parameters:
///   - spiceName: The name of the spice blend.
///   - servings: The number of servings.
///   - spicesData: The list of spices available for selection.
///   - isSelecting: A flag indicating if spices are being selected.
///   - showPopup: A flag indicating if the confirmation popup is visible.
///   - showBlending: A flag indicating if the blending view is visible.
///   - showCompletion: A flag indicating if the completion view is visible.
///   - showAlert: A flag indicating if the alert for incomplete blend is visible.
struct NewBlendView: View {
    @State private var spiceName = ""
    @State private var servings = 1
    @State private var spicesData = spiceData
    @State private var isSelecting: Bool = false
    @State private var showPopup = false
    @State private var showBlending = false
    @State private var showCompletion = false
    @State private var showAlert = false
    @State private var alertType: BlendAlertType? = nil

    @ObservedObject var recipeStore: RecipeStore

    let servingOptions = Array(1...10)

    var selectedIngredients: [Ingredient] {
        spicesData.filter { $0.isSelected }.map { Ingredient(name: $0.name, amount: $0.selectedAmount, unit: $0.unit) }
    }

    var body: some View {
        ZStack {
            VStack {
                TextField("Spice Blend Name", text: $spiceName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Servings:")
                    Picker(selection: $servings, label: Text("Servings")) {
                        ForEach(servingOptions, id: \.self) { option in
                            Text("\(option)")
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.horizontal)
                }

                ScrollView {
                    HStack(alignment: .top) {
                        VStack {
                            ForEach(spicesData.indices.filter { $0 < spicesData.count / 2 }, id: \.self) { index in
                                NewBlendSpiceView(spice: $spicesData[index], onSelect: { selected in
                                    spicesData[index].isSelected = selected
                                })
                            }
                        }
                        VStack {
                            ForEach(spicesData.indices.filter { $0 >= spicesData.count / 2 }, id: \.self) { index in
                                NewBlendSpiceView(spice: $spicesData[index], onSelect: { selected in
                                    spicesData[index].isSelected = selected
                                })
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }

            VStack {
                Spacer()
                Button(action: {
                    if spiceName.isEmpty || selectedIngredients.isEmpty {
                        alertType = .incompleteBlend
                        showAlert = true
                    } else {
                        alertType = .saveToRecipeBook
                        showAlert = true
                    }
                }) {
                    Text("BLEND")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    switch alertType {
                    case .incompleteBlend:
                        return Alert(
                            title: Text("Incomplete Blend"),
                            message: Text("Please enter a spice blend name and select at least one ingredient."),
                            dismissButton: .default(Text("OK"))
                        )
                    case .saveToRecipeBook:
                        return Alert(
                            title: Text("Save Blend"),
                            message: Text("Do you want to save this blend to your recipe book?"),
                            primaryButton: .default(Text("Yes"), action: {
                                if recipeStore.recipes.contains(where: { $0.name.lowercased() == spiceName.lowercased() }) {
                                    alertType = .duplicateBlendName
                                    DispatchQueue.main.async {
                                        showAlert = true
                                    }
                                } else {
                                    let ingredients = selectedIngredients
                                    let newRecipe = Recipe(
                                        name: spiceName,
                                        ingredients: ingredients,
                                        servings: servings
                                    )
                                    recipeStore.addRecipe(newRecipe)
                                    showPopup = true
                                }
                            }),
                            secondaryButton: .cancel(Text("No"), action: {
                                showPopup = true
                            })
                        )
                    case .duplicateBlendName:
                        return Alert(
                            title: Text("Error"),
                            message: Text("A recipe with this name already exists."),
                            dismissButton: .default(Text("OK"))
                        )
                    case .none:
                        return Alert(title: Text("Unknown Alert"))
                    }
                }
                .sheet(isPresented: $showPopup) {
                    BlendConfirmationView(spiceName: spiceName, servings: servings, ingredients: selectedIngredients, onConfirm: {
                        showPopup = false
                        showBlending = true
                    })
                }
                .sheet(isPresented: $showBlending) {
                    BlendingView(spiceName: spiceName, servings: servings, ingredients: selectedIngredients, onComplete: {
                        showBlending = false
                        showCompletion = true
                    })
                }
                .sheet(isPresented: $showCompletion) {
                    BlendCompletionView(onDone: {
                        showCompletion = false
                    })
                }
            }
        }
    }
}

#Preview {
    NewBlendView(recipeStore: RecipeStore())
}

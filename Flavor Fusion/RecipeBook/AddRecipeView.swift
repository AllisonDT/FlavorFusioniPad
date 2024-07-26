//
//  RecipeModel.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/20/24.
//

import SwiftUI

struct AddRecipeView: View {
    @Binding var isPresented: Bool
    @ObservedObject var recipeStore: RecipeStore

    @State private var recipeName: String = ""
    @State private var servings = 1
    @State private var spicesData = spiceData
    @State private var selectedSpices: [Spice: Int] = [:]
    @State private var showPopup = false
    @State private var showBlending = false
    @State private var showCompletion = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    let servingOptions = Array(1...10)

    var selectedIngredients: [String] {
        spicesData.filter { $0.isSelected }.map { $0.name }
    }

    var body: some View {
        ZStack {
            VStack {
                // Header
                Text("Create Recipe")
                    .font(.largeTitle)
//                    .fontWeight(.bold)
                    .padding(.top)
                
                TextField("Recipe Name", text: $recipeName)
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
                        // First column
                        VStack {
                            ForEach(spicesData.indices.filter { $0 < spicesData.count / 2 }, id: \.self) { index in
                                AddRecipeSpiceView(spice: $spicesData[index], selectedSpices: $selectedSpices)
                            }
                        }
                        // Second column
                        VStack {
                            ForEach(spicesData.indices.filter { $0 >= spicesData.count / 2 }, id: \.self) { index in
                                AddRecipeSpiceView(spice: $spicesData[index], selectedSpices: $selectedSpices)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }

            VStack {
                Spacer()
                Button(action: {
                    if recipeName.isEmpty {
                        alertMessage = "Please enter a recipe name."
                        showAlert = true
                        return
                    }

                    if selectedSpices.isEmpty {
                        alertMessage = "Please select at least one spice."
                        showAlert = true
                        return
                    }

                    let ingredients = selectedSpices.map { Ingredient(name: $0.key.name, amount: Double($0.value)) }
                    let newRecipe = Recipe(
                        name: recipeName,
                        ingredients: ingredients,
                        servings: servings
                    )
                    recipeStore.addRecipe(newRecipe)
                    isPresented = false
                }) {
                    Text("SAVE")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                }
                .padding(.horizontal)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct AddRecipeSpiceView: View {
    @Binding var spice: Spice
    @Binding var selectedSpices: [Spice: Int]

    let spiceQuantities = Array(1...10)

    var body: some View {
        HStack {
            Button(action: {
                if self.selectedSpices.keys.contains(spice) {
                    self.selectedSpices.removeValue(forKey: spice)
                } else {
                    self.selectedSpices[spice] = 1
                }
            }) {
                Image(systemName: self.selectedSpices.keys.contains(spice) ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(self.selectedSpices.keys.contains(spice) ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())

            Text(spice.name)
                .foregroundColor(.black)
                .font(.body)

            Spacer()

            if self.selectedSpices.keys.contains(spice) {
                Picker("Quantity", selection: Binding(
                    get: { self.selectedSpices[spice] ?? 1 },
                    set: { self.selectedSpices[spice] = $0 }
                )) {
                    ForEach(spiceQuantities, id: \.self) { quantity in
                        Text("\(quantity)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .frame(width: 70)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
        )
        .padding(.vertical, 5)
    }
}

struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView(isPresented: .constant(false), recipeStore: RecipeStore())
    }
}

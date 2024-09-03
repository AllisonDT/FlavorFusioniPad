//
//  SpicePopupView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpicePopupView: View {
    @ObservedObject var spiceDataViewModel: SpiceDataViewModel
    @State private var editedSpiceName: String
    @State private var isEditing: Bool = false
    let spice: Spice
    let recipes: [Recipe]
    @Binding var isPresented: Bool

    init(spice: Spice, recipes: [Recipe], isPresented: Binding<Bool>, spiceDataViewModel: SpiceDataViewModel) {
        self.spice = spice
        self.recipes = recipes
        self._isPresented = isPresented
        self._spiceDataViewModel = ObservedObject(initialValue: spiceDataViewModel)
        self._editedSpiceName = State(initialValue: spice.name)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    SpiceIndicator(amount: spice.spiceAmount, isSelected: true)
                        .padding(.trailing, 10)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        if isEditing {
                            TextField("Spice Name", text: $editedSpiceName)
                                .padding(8)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.blue, lineWidth: 2)
                                )
                                .font(.title2)
                                .bold()
                        } else {
                            Text(editedSpiceName)
                                .font(.title2)
                                .bold()
                                .foregroundColor(.primary)
                        }
                        
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
            }
            .padding()
            .background(Color(.systemGroupedBackground))
            .navigationBarTitle("Spice Details", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    isEditing.toggle()
                    if !isEditing {
                        spiceDataViewModel.updateSpiceName(containerNumber: spice.containerNumber, newName: editedSpiceName)
                    }
                }) {
                    Text(isEditing ? "Save" : "Edit")
                        .bold()
                },
                trailing: Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
            )
        }
    }
}

//
//  AddRecipeView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 6/6/24.
//

import SwiftUI

struct AddRecipeView: View {
    @Binding var isPresented: Bool
    @ObservedObject var recipeStore: RecipeStore
    
    @State private var recipeName: String = ""
    @State private var selectedServingsIndex: Int = 0
    let servings = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @State private var selectedSpices: [Spice: Int] = [:]
    let spiceQuantities = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    var body: some View {
        ZStack {
            VStack {
                // Text field for entering recipe name
                TextField("Enter Recipe Name", text: $recipeName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Picker for selecting number of servings
                Picker("Servings", selection: $selectedServingsIndex) {
                    ForEach(0..<servings.count) {
                        Text("\(self.servings[$0]) servings")
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                .padding()
                
                // Spice list
                ScrollView {
                    ForEach(spicesData) { spice in
                        HStack {
                            // Checkbox circle on the left
                            Button(action: {
                                if self.selectedSpices.keys.contains(spice) {
                                    self.selectedSpices.removeValue(forKey: spice)
                                } else {
                                    self.selectedSpices[spice] = 1 // Default quantity to 1
                                }
                            }) {
                                Image(systemName: self.selectedSpices.keys.contains(spice) ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(self.selectedSpices.keys.contains(spice) ? .green : .gray)
                            }
                            Spacer()
                            Text(spice.name)
                            Spacer()
                            // Quantity picker
                            if self.selectedSpices.keys.contains(spice) {
                                Picker("Quantity", selection: Binding(
                                    get: { self.selectedSpices[spice] ?? 1 },
                                    set: { self.selectedSpices[spice] = $0 }
                                )) {
                                    ForEach(spiceQuantities, id: \.self) { quantity in
                                        Text("\(quantity)")
                                    }
                                }
                                .pickerStyle(MenuPickerStyle()) // Adjust picker style as needed
                                .frame(width: 100) // Adjust width as needed
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            
            // Floating save button
            VStack {
                Spacer()
                Button(action: {
                    // Save the new recipe to RecipeStore
                    let newRecipe = Recipe(
                        name: recipeName,
                        ingredients: Array(selectedSpices.keys.map { $0.name }),
                        servings: servings[selectedServingsIndex]
                    )
                    recipeStore.addRecipe(newRecipe)
                    // Dismiss the view after saving
                    isPresented = false
                }) {
                    Text("SAVE")
                        .frame(width: 200, height: 60)
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.green, lineWidth: 2)
                        )
                        .background(Color.green.opacity(0.5))
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}




//
//struct AddRecipeView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecipeView(isPresented: .constant(false), recipeStore: recipeStore)
//    }
//}



/*ScrollView {
    HStack {
        LazyVGrid(columns: [GridItem(.flexible())]) {
            ForEach(firstColumnSpices) { spice in
                SpiceBlendSelections(spice: spice, isSelecting: isSelecting) { selected in
                    if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                        spicesData[index].isSelected = selected
                    }
                }
            }
        }
        .padding()
        
        LazyVGrid(columns: [GridItem(.flexible())]) {
            ForEach(secondColumnSpices) { spice in
                SpiceBlendSelections(spice: spice, isSelecting: isSelecting) { selected in
                    if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                        spicesData[index].isSelected = selected
                    }
                }
            }
        }
        .padding()
    }
}*/

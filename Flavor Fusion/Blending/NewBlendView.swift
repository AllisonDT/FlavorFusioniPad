//
//  NewBlendView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

struct NewBlendView: View {
    @State private var spiceName = ""
    @State private var servings = 1
    @State private var spicesData = spiceData
    @State private var isSelecting: Bool = false
    @State private var showPopup = false // State variable to control the popup presentation
    @State private var showBlending = false // State variable to control the blending view
    @State private var showCompletion = false // State variable to control the completion view

    let servingOptions = Array(1...10) // Array of serving options

    var selectedIngredients: [String] {
        spicesData.filter { $0.isSelected }.map { $0.name }
    }

    var body: some View {
        ZStack {
            VStack {
                TextField("Spice Blend Name", text: $spiceName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                HStack {
                    Text("Servings:") // Title next to the Picker
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
                                NewBlendSpiceView(spice: $spicesData[index], onSelect: { selected in
                                    spicesData[index].isSelected = selected
                                })
                            }
                        }
                        // Second column
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
                    showPopup = true // Show the popup when the button is pressed
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
                .sheet(isPresented: $showPopup) {
                    BlendConfirmationView(spiceName: spiceName, servings: servings, ingredients: selectedIngredients, onConfirm: {
                        showPopup = false
                        showBlending = true
                    })
                }
                .sheet(isPresented: $showBlending) {
                    BlendingView(onComplete: {
                        showBlending = false
                        showCompletion = true
                    })
                }
                .sheet(isPresented: $showCompletion) {
                    BlendCompletionView(onDone: {
                        // Navigate back to home page logic here
                        showCompletion = false
                    })
                }
            }
        }
    }
}

#Preview {
    NewBlendView()
}

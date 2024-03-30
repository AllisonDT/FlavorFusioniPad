//
//  NewBlendView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

struct NewBlendView: View {
    @State private var isSelecting: Bool = false
    @State private var spiceName = ""
    @State private var servings = 1
    let servingOptions = Array(1...10) // Array of serving options
    
    var body: some View {
        VStack {
            TextField("Spice Blend Name", text: $spiceName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Text("Servings:") // Title next to the Picker
                Picker(selection: $servings, label: Text("Servings")) {
                    ForEach(servingOptions, id: \.self) { option in
                        Text("\(option)")
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            
            HStack {
                // First column
                VStack {
                    ForEach(firstColumnSpices) { spice in
                        SpiceRowView(spice: spice, isSelecting: isSelecting) { selected in
                            if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                spicesData[index].isSelected = selected
                            }
                        }
                    }
                }
                
                // Second column
                VStack {
                    ForEach(secondColumnSpices) { spice in
                        SpiceRowView(spice: spice, isSelecting: isSelecting) { selected in
                            if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                spicesData[index].isSelected = selected
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    NewBlendView()
}

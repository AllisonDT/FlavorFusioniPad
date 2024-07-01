//
//  List.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

// This struct represents the List view.
struct List: View {
    // State variables for managing selection and visibility of blend popup.
    @State private var isSelecting: Bool = false
    @State private var isBlendPopupVisible: Bool = false

    var body: some View {
        VStack { // Wrap the VStack around the HStack
            // Title of the cabinet
//            Text("Allison's Cabinet")
//                .font(.title)
//                .padding(.bottom, 10)
            
            Button(action: {
                // Toggling visibility of blend popup
                isBlendPopupVisible.toggle()
            }) {
                Text("BLEND")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            
            HStack {
                // First column of spices
                VStack {
                    ForEach(firstColumnSpices) { spice in
                        // Displaying each spice row
                        SpiceRowView(spice: spice, isSelecting: isSelecting) { selected in
                            // Updating isSelected property of spice
                            if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                spicesData[index].isSelected = selected
                            }
                        }
                    }
                }
                
                // Second column of spices
                VStack {
                    ForEach(secondColumnSpices) { spice in
                        // Displaying each spice row
                        SpiceRowView(spice: spice, isSelecting: isSelecting) { selected in
                            // Updating isSelected property of spice
                            if let index = spicesData.firstIndex(where: { $0.id == spice.id }) {
                                spicesData[index].isSelected = selected
                            }
                        }
                    }
                }
            }
            .padding()
        }
        // Presenting the blend popup as a sheet when isBlendPopupVisible is true
        .sheet(isPresented: $isBlendPopupVisible) {
            BlendingNewExistingView()
        }
    }
}

// Preview Provider for the List view
struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}

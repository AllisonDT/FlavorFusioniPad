//
//  List.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct List: View {
    @State private var isSelecting: Bool = false
    @State private var isBlendPopupVisible: Bool = false // State to manage the visibility of the blend popup

    var body: some View {
        VStack { // Wrap the VStack around the HStack
            Text("Allison's Cabinet") // Add the title
                .font(.title)
                .padding(.bottom, 10) // Add some bottom padding
            
            // BLEND Button
            Button(action: {
                isBlendPopupVisible.toggle()
            }) {
                Text("BLEND")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue.opacity(0.5))
                    .clipShape(Ellipse()) // Oval shape
            }
            .padding(.bottom, 10) // Adjust bottom padding for the button
            
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
        .sheet(isPresented: $isBlendPopupVisible) {
            BlendingNewExistingView()
        }
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}

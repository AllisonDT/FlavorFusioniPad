//
//  BlendingNewExistingView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//
import SwiftUI

struct BlendingNewExistingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isNewBlendPopupVisible = false
    @State private var selectedOption = 0 // 0 for New, 1 for Existing
    
    var body: some View {
        NavigationView {
            VStack {
                // Segmented control for selecting new or existing
                Picker(selection: $selectedOption, label: Text("")) {
                    Text("New").tag(0)
                    Text("Existing").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // Display content based on selection
                if selectedOption == 0 {
                    NewBlendView()
                } else {
                    ExistingBlendView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Set a fixed frame size
        }
    }
}

#Preview {
    BlendingNewExistingView()
}

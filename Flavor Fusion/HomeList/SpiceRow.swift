//
//  SpiceRow.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpiceRow: View {
    let spice: Spice // Assuming Spice is the model struct
    let isSelecting: Bool
    var onTap: (Bool) -> Void

    @State private var isShowingPopup = false

    var body: some View {
        Button(action: {
            isShowingPopup.toggle()
        }) {
            Text(spice.name) // Assuming name is a property of Spice
                .foregroundColor(spice.isSelected ? .blue : .black)
        }
        .sheet(isPresented: $isShowingPopup) {
            SpicePopupView(spice: spice, isPresented: $isShowingPopup)
        }
    }
}

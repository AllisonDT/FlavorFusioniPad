//
//  SpiceBlendSelections.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import SwiftUI

struct SpiceBlendSelections: View {
    let spice: Spice
    let isSelecting: Bool
    let onSelect: (Bool) -> Void

    var body: some View {
        Button(action: {
            onSelect(!spice.isSelected)
        }) {
            Text(spice.name)
                .font(.headline) // Adjust font size as needed
                .foregroundColor(spice.isSelected ? .blue : .black)
                .padding(40) // Adjust padding as needed
                .frame(maxWidth: .infinity)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(Color.blue.opacity(0.1)) // Adjust color and opacity as needed
        )
    }
}

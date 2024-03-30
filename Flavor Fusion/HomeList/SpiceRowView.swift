//
//  SpiceRowView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpiceRowView: View {
    let spice: Spice
    let isSelecting: Bool
    let onSelect: (Bool) -> Void

    var body: some View {
        Rectangle()
            .foregroundColor(Color.blue.opacity(0.1)) // Adjust color and opacity as needed
            .overlay(
                SpiceRow(spice: spice, isSelecting: isSelecting) { selected in
                    onSelect(selected)
                }
            )
            .padding(.vertical, 4) // Adjust vertical padding as needed
    }
}

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
    let recipes: [Recipe]
    let onSelect: (Bool) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Simple background color
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(spice.isSelected ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                    .frame(width: geometry.size.width) // Stretch the rectangle to match width
                
                SpiceRow(spice: spice, isSelecting: isSelecting, recipes: recipes) { selected in
                    onSelect(selected)
                }
            }
        }
        .padding(.vertical, 4)
    }
}

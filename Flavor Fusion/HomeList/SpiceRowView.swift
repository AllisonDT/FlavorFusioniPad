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
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Overlay the Rectangle and the SpiceRow
                Rectangle()
                    .foregroundColor(Color.blue.opacity(Double(spice.spiceAmount))) // Adjust opacity based on spiceAmount
                    .frame(width: geometry.size.width) // Stretch the rectangle to match width
                SpiceRow(spice: spice, isSelecting: isSelecting) { selected in
                    onSelect(selected)
                }
            }
        }
        .padding(.vertical, 4) // Adjust vertical padding as needed
    }
}

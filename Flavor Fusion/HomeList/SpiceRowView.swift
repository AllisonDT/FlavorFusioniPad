//
//  SpiceRowView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

/// A view that displays a row representing a spice with selection capability.
///
/// `SpiceRowView` shows a spice and allows users to select or deselect it.
/// The background color changes based on the selection state.
///
/// - Parameters:
///   - spice: The spice to display in the row.
///   - isSelecting: A boolean indicating if the selection mode is active.
///   - recipes: A list of recipes that may contain the spice.
///   - spiceDataViewModel: The view model that manages the spice data.
///   - onSelect: A closure that is called when the spice is selected or deselected.
struct SpiceRowView: View {
    @ObservedObject var spiceDataViewModel: SpiceDataViewModel
    let spice: Spice
    let isSelecting: Bool
    let recipes: [Recipe]
    let onSelect: (Bool) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(spice.isSelected ? Color.blue.opacity(0.3) : Color.gray.opacity(0.1))
                    .frame(width: geometry.size.width)
                
                SpiceRow(spiceDataViewModel: spiceDataViewModel, spice: spice, isSelecting: isSelecting, recipes: recipes) { selected in
                    onSelect(selected)
                }
                .onTapGesture {
                    // Update the spice's selected state in the view model
                    if let index = spiceDataViewModel.spices.firstIndex(where: { $0.id == spice.id }) {
                        spiceDataViewModel.spices[index].isSelected.toggle()
                        onSelect(spiceDataViewModel.spices[index].isSelected)
                    }
                }
            }
        }
        .padding(.vertical, 4)
    }
}

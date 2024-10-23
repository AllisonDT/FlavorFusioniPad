//
//  SpiceRow.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

/// A row that displays a spice and its container number, with a popup for more details.
///
/// `SpiceRow` displays the name of a spice, its container number, and an indicator for the spice amount.
/// It includes a button that, when tapped, shows a popup with more detailed information about the spice. The row's appearance can change based on whether the spice is selected or not.
///
/// - Parameters:
///   - spiceDataViewModel: An `ObservedObject` that manages the spice data, allowing the view to reflect changes in spice information.
///   - spice: The `Spice` object representing the spice displayed in the row.
///   - isSelecting: A boolean that determines if the row is in selection mode.
///   - recipes: An array of `Recipe` objects related to the spice.
///   - onTap: A closure that is called when the spice is tapped, indicating whether it is selected.
struct SpiceRow: View {
    @ObservedObject var spiceDataViewModel: SpiceDataViewModel
    let spice: Spice
    let isSelecting: Bool
    let recipes: [Recipe]
    var onTap: (Bool) -> Void

    @State private var isShowingPopup = false

    var body: some View {
        Button(action: {
            isShowingPopup.toggle()
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(spice.name)
                        .foregroundColor(spice.isSelected ? .blue : .primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)

                    Spacer()

                    Text("Container: \(spice.containerNumber)")
                        .font(.caption)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .padding()

                ListSpiceIndicator(amount: spice.spiceAmount, isSelected: true)
                    .padding(.trailing, 10)
            }
            .frame(maxWidth: .infinity) // Fill the available width
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $isShowingPopup) {
            SpicePopupView(
                spice: spice,
                recipes: recipes,
                isPresented: $isShowingPopup,
                spiceDataViewModel: spiceDataViewModel
            )
        }
    }
}

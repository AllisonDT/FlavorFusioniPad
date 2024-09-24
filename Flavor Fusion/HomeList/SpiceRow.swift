//
//  SpiceRow.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

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
                }
                .padding()

                ListSpiceIndicator(amount: spice.spiceAmount, isSelected: true).padding(.trailing, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(UIColor.systemBackground))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
            )
            .padding(.vertical, 4)
        }
        .sheet(isPresented: $isShowingPopup) {
            SpicePopupView(spice: spice, recipes: recipes, isPresented: $isShowingPopup, spiceDataViewModel: spiceDataViewModel)
        }
    }
}

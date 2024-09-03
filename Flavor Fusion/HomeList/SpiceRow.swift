//
//  SpiceRow.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct SpiceRow: View {
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
            SpicePopupView(spice: spice, recipes: recipes, isPresented: $isShowingPopup, spiceDataViewModel: SpiceDataViewModel())
        }
    }
}





//                // Fullness indicator resembling a spice bottle
//                ZStack(alignment: .bottom) {
//                    Capsule()
//                        .frame(width: 20, height: 60)
//                        .foregroundColor(Color.gray.opacity(0.3))
//                    Capsule()
//                        .frame(width: 20, height: 60 * CGFloat(spice.spiceAmount))
//                        .foregroundColor(Color.blue)
//                }
//                .padding(.trailing, 10)

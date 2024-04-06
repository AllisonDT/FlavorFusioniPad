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
        VStack {
            Button(action: {
                isShowingPopup.toggle()
            }) {
                Text(spice.name) // Assuming name is a property of Spice
                    .foregroundColor(spice.isSelected ? .blue : .black)
            }
            .sheet(isPresented: $isShowingPopup) {
                SpicePopupView(spice: spice, isPresented: $isShowingPopup)
            }
            
            Spacer()
            
            // Display container number
            Text("Container: \(spice.containerNumber)")
                .font(.caption)
                .foregroundColor(.black)
        }
        .padding()
        .background(
            Rectangle()
                .fill(Color.blue.opacity(0.1)) // Background color of the rectangle
                .cornerRadius(8)
                .overlay(
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Blue gradient representing the amount of spice left
                            LinearGradient(gradient: Gradient(colors: [.blue, .blue.opacity(0.5)]), startPoint: .leading, endPoint: .trailing) // Blue gradient
                                .frame(width: geometry.size.width * CGFloat(spice.spiceAmount), height: geometry.size.height)
                        }
                    }
                )
        )
        .padding(.vertical, 4)
    }
}

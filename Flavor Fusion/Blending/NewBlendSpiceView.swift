//
//  NewBlendSpiceView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/9/24.
//

import SwiftUI

struct NewBlendSpiceView: View {
    @Binding var spice: Spice // Use Binding to reflect changes immediately
    let onSelect: (Bool) -> Void

    @State private var spiceAmount: Int = 1
    private let spiceAmounts = Array(1...10)

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Button(action: {
                    onSelect(!spice.isSelected) // Toggle isSelected state
                }) {
                    Circle()
                        .stroke(spice.isSelected ? Color.green : Color.gray, lineWidth: 2)
                        .background(Circle().foregroundColor(spice.isSelected ? Color.green : Color.clear))
                        .frame(width: 24, height: 24)
                        .padding(.leading, 8)
                }

                Text(spice.name)
                    .font(.headline)
                    .foregroundColor(spice.isSelected ? .green : .black)
                    .padding(.leading, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.vertical, 6)
            .padding(.trailing, 8)

            // Spice amount picker
            HStack {
                Text("Amount:")
                    .font(.subheadline)
                    .padding(.leading, 8)
                
                Picker("Amount", selection: $spiceAmount) {
                    ForEach(spiceAmounts, id: \.self) { amount in
                        Text("\(amount)")
                            .tag(amount)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal, 8)
                .padding(.bottom, 4)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 8) // Matching corner radius
                .fill(Color.white) // Matching background color
                .shadow(color: .gray, radius: 2, x: 0, y: 2) // Matching shadow
        )
        .padding(.vertical, 4)
    }
}

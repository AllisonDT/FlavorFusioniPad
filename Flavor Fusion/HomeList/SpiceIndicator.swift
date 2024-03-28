//
//  SpiceIndicator.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 2/5/24.
//

import SwiftUI

// SpiceIndicator View: Displays a circular indicator representing the amount of a spice
struct SpiceIndicator: View {
    var amount: Double
    var isSelected: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 2)
                .foregroundColor(isSelected ? .green : .clear)
            // Adjust the angles based on the spice amount
            Circle().trim(from: 0.0, to: CGFloat(amount))
                .stroke(Color.green, lineWidth: 4)
                .rotationEffect(Angle(degrees: -90))
        }
        .frame(width: 30, height: 30)
    }
}

#Preview {
    SpiceIndicator(amount: 0.5, isSelected: true)
}

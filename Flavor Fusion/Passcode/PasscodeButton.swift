//
//  PasscodeButton.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

import SwiftUI

struct PasscodeButton: View {
    var number: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title)
                .fontWeight(.semibold)
                .frame(width: 80, height: 80)
                .foregroundColor(.primary)
                .background(Color(.systemGray5))
                .cornerRadius(40)
        }
    }
}

//
//  PasscodeButton.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/25/24.
//

import SwiftUI

struct PasscodeButton: View {
    let number: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(number)
                .font(.title)
                .frame(width: 80, height: 80)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(40)
        }
    }
}

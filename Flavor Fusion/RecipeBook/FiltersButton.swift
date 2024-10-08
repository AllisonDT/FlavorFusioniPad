//
//  FiltersButton.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 10/8/24.
//

import SwiftUI

/// A button view for filters functionality.
///
/// `FiltersButton` displays a button that can be used to apply filters.
struct FiltersButton: View {
    var body: some View {
        Button(action: {
        }) {
            Image(systemName: "line.horizontal.3.decrease.circle")
                .font(.system(size: 24))
                .padding()
                .foregroundColor(.blue)
        }
    }
}


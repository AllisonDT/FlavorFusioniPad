//
//  FavoriteRecipeCircle.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/31/24.
//

import SwiftUI

struct FavoriteRecipeCircle: View {
    var spiceName: String
    
    var body: some View {
        Text(spiceName)
            .font(.headline)
            .frame(width: 100, height: 100)
            .foregroundColor(.black)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.black, lineWidth: 2))
    }
}

#Preview {
    FavoriteRecipeCircle(spiceName: "Taco")
}

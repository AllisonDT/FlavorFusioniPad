//
//  BlendCompletionView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 7/13/24.
//

import SwiftUI

/// A view that displays the completion message and a button to return to the home page.
///
/// `BlendCompletionView` shows a large "Complete!" text, a green checkmark, and a custom message.
/// Below the message, a "Done" button allows the user to navigate back to the home page.
///
/// - Parameters:
///   - onDone: A closure that is called when the "Done" button is pressed.
struct BlendCompletionView: View {
    let onDone: () -> Void

    var body: some View {
        VStack {
            Text("Complete!")
                .font(.largeTitle)
                .padding(.top)

            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding()

            Text("Have a spicy day!")
                .font(.title2)
                .padding(.top)

            Spacer()

            Button(action: onDone) {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    BlendCompletionView(onDone: {})
}

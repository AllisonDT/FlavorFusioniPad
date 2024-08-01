//
//  UserManualView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 4/6/24.
//

import SwiftUI

struct UserManualView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionView(title: "Getting Started") {
                    BulletPoint(text: "Unbox Flavor Fusion.")
                    BulletPoint(text: "Plug in the device to a power source.")
                    BulletPoint(text: "Download the Flavor Fusion mobile app from the App Store.")
                }
                
                SectionView(title: "Using the Device") {
                    BulletPoint(text: "Press the power button to turn on/off the device.")
                    BulletPoint(text: "Refill spice cartridges when empty.")
                }
                
                SectionView(title: "Troubleshooting") {
                    BulletPoint(text: "If the device does not turn on, check the power connection.")
                    BulletPoint(text: "If the LCD screen is unresponsive, restart the device.")
                    BulletPoint(text: "For any other issues, refer to the user manual or contact customer support.")
                }
            }
            .padding()
        }
    }
}

struct SectionView<Content: View>: View {
    var title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            content
        }
    }
}

struct BulletPoint: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("•")
            Text(text)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    UserManualView()
}

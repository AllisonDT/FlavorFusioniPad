//
//  PrivacyInfoView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 4/6/24.
//

import SwiftUI

struct PrivacyInfoView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Privacy and Security")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text("Flavor Fusion utilizes Bluetooth technology to connect with your mobile device. Your privacy and security are important to us. Here's how we handle Bluetooth data:")
                    .font(.body)
                    .foregroundColor(.black)
                
                SectionViewPrivacy(title: "Data Collection") {
                    BulletPointPrivacy(text: "Flavor Fusion collects and processes Bluetooth signals for the purpose of establishing a connection with your mobile device.")
                    BulletPointPrivacy(text: "We do not collect or store any personally identifiable information through Bluetooth.")
                }
                
                SectionViewPrivacy(title: "Data Usage") {
                    BulletPointPrivacy(text: "Bluetooth data is solely used for the operation of Flavor Fusion, such as uploading custom blends and recipes.")
                    BulletPointPrivacy(text: "We do not share Bluetooth data with third parties for any purposes.")
                }
                
                SectionViewPrivacy(title: "Data Security") {
                    BulletPointPrivacy(text: "Bluetooth data is encrypted during transmission to ensure its security.")
                    BulletPointPrivacy(text: "We employ industry-standard security measures to protect Bluetooth data from unauthorized access or disclosure.")
                }
            }
            .padding()
        }
    }
}

struct SectionViewPrivacy<Content: View>: View {
    var title: String
    var content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.black)
            content
        }
    }
}

struct BulletPointPrivacy: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 5) {
            Text("•")
            Text(text)
                .font(.body)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    PrivacyInfoView()
}

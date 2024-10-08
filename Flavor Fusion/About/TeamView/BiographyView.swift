//
//  BiographyView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 10/8/24.
//

import SwiftUI

/// A view that displays the biography of a team member.
///
/// `BiographyView` shows the team member's picture or a default silhouette, name, position, and biography.
///
/// - Parameters:
///   - member: The team member whose biography is displayed.
struct BiographyView: View {
    let member: TeamMember
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            VStack {
                // Display team member's picture or silhouette
                if let imageName = member.imageName, let uiImage = UIImage(named: imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 20)
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.bottom, 20)
                }

                Text(member.name)
                    .font(.largeTitle)
                    .padding(.bottom, 5)
                Text(member.position)
                    .font(.title)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 20)
                Text(member.biography)
                    .font(.body)
                    .padding()
                Spacer()
            }
            .padding()
            .padding(.top, 20)
            .background(Color(UIColor.systemBackground))
            .navigationBarItems(trailing: Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.primary)
            })
        }
    }
}

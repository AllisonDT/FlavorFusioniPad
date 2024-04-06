//
//  TeamView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 4/6/24.
//

import SwiftUI

struct TeamView: View {
    let teamMembers = [
        ("Ryan Latterell", "Project Manager"),
        ("Allison Turner", "Developer"),
        ("Samuel Pabon", "Engineer"),
        ("Alexandra Figueroa", "Engineer"),
        ("Thomas Spurlock", "Engineer"),
        ("Ethan Butterfield", "Engineer")
    ]

    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<3) { row in
                HStack(spacing: 20) {
                    ForEach(0..<2) { column in
                        if let index = self.indexFor(row: row, column: column) {
                            TeamMemberView(name: self.teamMembers[index].0, position: self.teamMembers[index].1)
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
    }

    func indexFor(row: Int, column: Int) -> Int? {
        let index = row * 2 + column
        return index < teamMembers.count ? index : nil
    }
}

struct TeamMemberView: View {
    let name: String
    let position: String

    var body: some View {
        VStack {
            // Headshot placeholder
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .padding(.bottom, 5)
            
            // Name and position
            Text(name)
                .font(.headline)
            Text(position)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    TeamView()
}

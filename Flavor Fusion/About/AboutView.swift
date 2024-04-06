//
//  AboutView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    NavigationLink(destination: ProjectOverviewView()) {
                        CustomListItem(title: "Project Overview")
                    }
                    NavigationLink(destination: UserManualView()) {
                        CustomListItem(title: "User Manual")
                    }
                    NavigationLink(destination: PrivacyInfoView()) {
                        CustomListItem(title: "Privacy Information")
                    }
                    NavigationLink(destination: TeamView()) {
                        CustomListItem(title: "Meet the Team")
                    }
                }
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 300))
                    .foregroundColor(.blue.opacity(0.5))
                    .padding()
            }
        }
    }
}

struct CustomListItem: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.horizontal)
                .foregroundColor(.primary)
                .padding(.vertical, 15)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
                .padding(.trailing)
                .padding(.vertical, 15)
        }
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

#Preview {
    AboutView()
}

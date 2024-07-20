//
//  AboutView.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/24/24.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("About Flavor Fusion")
                    .font(.title)
                    .padding(.bottom, 10)
                
                VStack(spacing: 15) {
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
                .padding(.horizontal)
                
                Spacer()
                
                Image(systemName: "exclamationmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue.opacity(0.5))
                    .padding(.bottom, 20)
                
                Spacer()
            }
            .padding()
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
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
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.3), radius: 2, x: 0, y: 2)
        .padding(.vertical, 4)
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

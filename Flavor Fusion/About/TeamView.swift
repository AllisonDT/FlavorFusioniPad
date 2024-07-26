import SwiftUI

// Define a TeamMember struct conforming to Identifiable
struct TeamMember: Identifiable {
    let id = UUID()
    let name: String
    let position: String
    let biography: String
    let imageName: String?
}

// This struct represents the Team View.
struct TeamView: View {
    // Array containing team members and their positions and biographies
    let teamMembers = [
        TeamMember(name: "Ryan Latterell", position: "Project Manager", biography: "Ryan's Biography", imageName: "ryan"),
        TeamMember(name: "Allison Turner", position: "Developer", biography: "Allison's Biography", imageName: "allison"),
        TeamMember(name: "Samuel Pabon", position: "Engineer", biography: "Sam's Biography", imageName: "sam"),
        TeamMember(name: "Alexandra Figueroa", position: "Engineer", biography: "Alex's Biography", imageName: "alex"),
        TeamMember(name: "Thomas Spurlock", position: "Engineer", biography: "Thomas' Biography", imageName: "thomas"),
        TeamMember(name: "Ethan Butterfield", position: "Engineer", biography: "Ethan's Biography", imageName: nil) // No image for Ethan
    ]
    
    @State private var selectedMember: TeamMember? = nil

    var body: some View {
        VStack(spacing: 20) {
            // Iterating through rows
            ForEach(0..<3) { row in
                HStack(spacing: 20) {
                    // Iterating through columns
                    ForEach(0..<2) { column in
                        if let index = self.indexFor(row: row, column: column) {
                            // Displaying team member view
                            TeamMemberView(member: self.teamMembers[index])
                                .onTapGesture {
                                    self.selectedMember = self.teamMembers[index]
                                }
                        } else {
                            Spacer()
                        }
                    }
                }
            }
        }
        .padding()
        .sheet(item: $selectedMember) { member in
            BiographyView(member: member)
        }
    }

    // Function to calculate index for team members array
    func indexFor(row: Int, column: Int) -> Int? {
        let index = row * 2 + column
        return index < teamMembers.count ? index : nil
    }
}

// This struct represents the view for an individual team member.
struct TeamMemberView: View {
    let member: TeamMember

    var body: some View {
        VStack {
            // Display team member's picture or silhouette
            if let imageName = member.imageName, let uiImage = UIImage(named: imageName) {
                Image(uiImage: uiImage)
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 5)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 5)
            }
            
            // Displaying team member's name and position
            Text(member.name)
                .font(.headline)
            Text(member.position)
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

// This struct represents the biography view for a team member.
struct BiographyView: View {
    let member: TeamMember

    var body: some View {
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
                .foregroundColor(.gray)
                .padding(.bottom, 20)
            Text(member.biography)
                .font(.body)
                .padding()
            Spacer()
        }
        .padding()
        .padding(.top, 20)
    }
}

// Preview Provider for the TeamView
#Preview {
    TeamView()
}

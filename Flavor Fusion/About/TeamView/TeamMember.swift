//
//  TeamMember.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 10/8/24.
//

import SwiftUI

/// A struct representing a team member.
struct TeamMember: Identifiable {
    let id = UUID()
    let name: String
    let position: String
    let biography: String
    let imageName: String?
}


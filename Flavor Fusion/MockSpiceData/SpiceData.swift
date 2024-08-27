//
//  SpiceData.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 2/5/24.
//

import Foundation

// Spice Data Model
public struct Spice: Identifiable, Equatable, Hashable {
    public let id = UUID()
    public var name: String
    public var spiceAmount: Double // This will store the amount in the chosen unit (tsp/tbsp)
    public var isSelected: Bool = false
    public var containerNumber: Int
    public var selectedAmount: Double = 0.0
    public var unit: String = "t" // Default unit is teaspoons
    public var amountInGrams: Double // This will store the amount in grams

    public init(name: String, amountInGrams: Double, containerNumber: Int) {
        self.name = name
        self.amountInGrams = amountInGrams
        self.containerNumber = containerNumber
        self.spiceAmount = Spice.convertGramsToUnit(grams: amountInGrams, unit: unit)
    }
    
    // Function to convert grams to the specified unit
    public static func convertGramsToUnit(grams: Double, unit: String) -> Double {
        switch unit {
        case "t": // teaspoons
            return grams / 4.2 // Example conversion factor, adjust as needed
        case "T": // tablespoons
            return grams / 14.3 // Example conversion factor, adjust as needed
        default:
            return grams
        }
    }

    // Function to update the spice amount when the unit changes
    public mutating func updateUnit(to newUnit: String) {
        self.unit = newUnit
        self.spiceAmount = Spice.convertGramsToUnit(grams: self.amountInGrams, unit: newUnit)
    }
}

// Example usage
public var spiceData = [
    Spice(name: "Spice 1", amountInGrams: 1.0, containerNumber: 1),
    Spice(name: "Spice 2", amountInGrams: 0.5, containerNumber: 2),
    Spice(name: "Spice 3", amountInGrams: 0.25, containerNumber: 3),
    Spice(name: "Spice 4", amountInGrams: 0.8, containerNumber: 4),
    Spice(name: "Spice 5", amountInGrams: 0.3, containerNumber: 5),
    Spice(name: "Spice 6", amountInGrams: 0.6, containerNumber: 6),
    Spice(name: "Spice 7", amountInGrams: 0.2, containerNumber: 7),
    Spice(name: "Spice 8", amountInGrams: 0.9, containerNumber: 8),
    Spice(name: "Spice 9", amountInGrams: 0.4, containerNumber: 9),
    Spice(name: "Spice 10", amountInGrams: 0.7, containerNumber: 10)
]

//
//class SpiceDataStore: ObservableObject {
//    @Published var spiceData: [Spice] = [
//        Spice(name: "Spice 1", amountInGrams: 1.0, containerNumber: 1),
//        Spice(name: "Spice 2", amountInGrams: 0.5, containerNumber: 2),
//        // Add other spices here...
//        Spice(name: "Spice 10", amountInGrams: 0.7, containerNumber: 10)
//    ]
//}

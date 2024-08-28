//
//  SpiceData.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 2/5/24.
//

import Foundation
import Combine

// Spice Data Model
public struct Spice: Identifiable, Equatable, Hashable, Encodable, Decodable {
    public var id = UUID()
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

// Default spice data array
//public var spiceData = [
//    Spice(name: "Spice 1", amountInGrams: 3.0, containerNumber: 1),
//    Spice(name: "Spice 2", amountInGrams: 2.5, containerNumber: 2),
//    Spice(name: "Spice 3", amountInGrams: 1.25, containerNumber: 3),
//    Spice(name: "Spice 4", amountInGrams: 1.8, containerNumber: 4),
//    Spice(name: "Spice 5", amountInGrams: 1.3, containerNumber: 5),
//    Spice(name: "Spice 6", amountInGrams: 1.6, containerNumber: 6),
//    Spice(name: "Spice 7", amountInGrams: 1.2, containerNumber: 7),
//    Spice(name: "Spice 8", amountInGrams: 0.6, containerNumber: 8),
//    Spice(name: "Spice 9", amountInGrams: 1.4, containerNumber: 9),
//    Spice(name: "Spice 10", amountInGrams: 1.7, containerNumber: 10)
//]

// SpiceDataViewModel
public class SpiceDataViewModel: ObservableObject {
    @Published public var spices: [Spice]
    
    public init() {
        self.spices = []
        self.loadSpices()
    }
    
    // Save spices array to UserDefaults
    private func saveSpices() {
        if let encoded = try? JSONEncoder().encode(spices) {
            UserDefaults.standard.set(encoded, forKey: "savedSpices")
            print("Spices saved successfully.")
        } else {
            print("Failed to encode and save spices.")
        }
    }
    
    // Load spices array from UserDefaults
    private func loadSpices() {
        if let savedSpices = UserDefaults.standard.data(forKey: "savedSpices"),
           let decodedSpices = try? JSONDecoder().decode([Spice].self, from: savedSpices) {
            self.spices = decodedSpices
            spiceData = decodedSpices // Populate spiceData with the loaded data
            print("Spices loaded from UserDefaults: \(spices)")
        } else {
            print("No saved spices found in UserDefaults.")
            // You might want to initialize spices with an empty array or handle the case where there's no data
        }
    }
    
    // Function to update a spice amount by container number
    public func updateSpice(containerNumber: Int, newAmountInGrams: Double) {
        if let index = spices.firstIndex(where: { $0.containerNumber == containerNumber }) {
            spices[index].amountInGrams = newAmountInGrams
            spices[index].spiceAmount = Spice.convertGramsToUnit(grams: newAmountInGrams, unit: spices[index].unit)
            print("Updated \(spices[index].name) with spiceAmount: \(spices[index].spiceAmount) \(spices[index].unit) from Bluetooth.")
            
            // Update the spiceData array as well
            spiceData[index] = spices[index]
            
            // Save updated spices to UserDefaults
            saveSpices()
        } else {
            print("Spice with containerNumber \(containerNumber) not found.")
        }
    }
    
    // Function to handle bulk updates of spice data, e.g., when multiple spices are updated via Bluetooth
    public func updateAllSpices(newSpiceData: [Spice]) {
        for newSpice in newSpiceData {
            updateSpice(containerNumber: newSpice.containerNumber, newAmountInGrams: newSpice.amountInGrams)
        }
    }
}

// Now you can declare spiceData globally
public var spiceData: [Spice] = []

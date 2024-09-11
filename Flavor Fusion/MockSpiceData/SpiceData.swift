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

// SpiceDataViewModel
public class SpiceDataViewModel: ObservableObject {
    @Published public var spices: [Spice]
    
    public init() {
        self.spices = []
        self.loadSpices()
    }
    
    // Save spices array to UserDefaults
    public func saveSpices() {
        if let encoded = try? JSONEncoder().encode(spices) {
            UserDefaults.standard.set(encoded, forKey: "savedSpices")
            print("Spices saved successfully.")
        } else {
            print("Failed to encode and save spices.")
        }
    }
    
    // Load spices array from UserDefaults
    public func loadSpices() {
        if let savedSpices = UserDefaults.standard.data(forKey: "savedSpices"),
           let decodedSpices = try? JSONDecoder().decode([Spice].self, from: savedSpices) {
            self.spices = decodedSpices
            spiceData = decodedSpices // Populate spiceData with the loaded data
            print("Spices loaded from UserDefaults: \(spices)")
        } else {
            print("No saved spices found in UserDefaults.")
            // initialize spices with an empty array or handle the case where there's no data
        }
    }
    
    // Function to update the spice name
    public func updateSpiceName(containerNumber: Int, newName: String) {
        if let index = spices.firstIndex(where: { $0.containerNumber == containerNumber }) {
            spices[index].name = newName
            spiceData[index].name = newName
            saveSpices()
            print("Updated spice name to \(newName) for containerNumber \(containerNumber).")
        }
    }
    
    // Function to update a spice amount by container number
    public func updateSpice(containerNumber: Int, newAmountInGrams: Double) {
        if let index = spices.firstIndex(where: { $0.containerNumber == containerNumber }) {
            spices[index].amountInGrams = newAmountInGrams
            spices[index].spiceAmount = Spice.convertGramsToUnit(grams: newAmountInGrams, unit: spices[index].unit)
            
            print("Updated spice data from Bluetooth:")
            print("Container Number: \(containerNumber)")
            print("Amount in Grams: \(newAmountInGrams)")
            print("Converted Amount: \(spices[index].spiceAmount) \(spices[index].unit)")
            
            spiceData[index] = spices[index]
        } else {
            let newSpice = Spice(name: "Spice \(containerNumber)", amountInGrams: newAmountInGrams, containerNumber: containerNumber)
            spices.append(newSpice)
            spiceData.append(newSpice)
            
            print("Added new spice from Bluetooth:")
            print("Container Number: \(containerNumber)")
            print("Amount in Grams: \(newAmountInGrams)")
            print("Converted Amount: \(newSpice.spiceAmount) \(newSpice.unit)")
        }
        
        // Sort the spices by container number
        spices.sort { $0.containerNumber < $1.containerNumber }
        spiceData.sort { $0.containerNumber < $1.containerNumber }
        
        saveSpices()
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

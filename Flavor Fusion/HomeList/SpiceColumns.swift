//
//  SpiceColumns.swift
//  Flavor Fusion
//
//  Created by Allison Turner on 3/30/24.
//

import Foundation

// Splitting spicesData into two arrays for two columns
public var firstColumnSpices: [Spice] {
    Array(spicesData.prefix(spicesData.count / 2))
}

public var secondColumnSpices: [Spice] {
    Array(spicesData.suffix(spicesData.count / 2))
}

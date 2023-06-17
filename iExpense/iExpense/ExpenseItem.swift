//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Joey Rideout on 2023-06-17.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

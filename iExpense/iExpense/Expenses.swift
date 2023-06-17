//
//  Expenses.swift
//  iExpense
//
//  Created by Joey Rideout on 2023-06-17.
//

import Foundation

class Expenses: ObservableObject {
    var type: String
    var keyName: String
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: self.keyName)
            }
        }
    }
    init(type: String) {
        self.type = type
        self.keyName = type + "Items"
        
        if let savedItems = UserDefaults.standard.data(forKey: self.keyName) {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
    }
}

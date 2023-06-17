//
//  AddView.swift
//  iExpense
//
//  Created by Joey Rideout on 2023-06-17.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var personalExpenses: Expenses
    @ObservedObject var businessExpenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    if type == "Business" {
                        businessExpenses.items.append(item)
                    } else {
                        personalExpenses.items.append(item)
                    }
                    
                    dismiss()
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(personalExpenses: Expenses(type: "Personal"), businessExpenses: Expenses(type: "Business"))
    }
}

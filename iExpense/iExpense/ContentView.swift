//
//  ContentView.swift
//  iExpense
//
//  Created by Joey Rideout on 2023-06-17.
//

import SwiftUI

struct ContentView: View {
    @StateObject var personalExpenses = Expenses(type: "Personal")
    @StateObject var businessExpenses = Expenses(type: "Business")
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                List {
                    ForEach(personalExpenses.items) { item in
                        var amountColor: Color {
                            if item.amount < 10 {
                                return .secondary
                            } else if item.amount < 100 {
                                return .primary
                            } else {
                                return .red
                            }
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(amountColor)
                        }
                    }
                    .onDelete(perform: removePersonalItem)
                }
                List {
                    ForEach(businessExpenses.items) { item in
                        var amountColor: Color {
                            if item.amount < 10 {
                                return .secondary
                            } else if item.amount < 100 {
                                return .primary
                            } else {
                                return .red
                            }
                        }
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(amountColor)
                        }
                    }
                    .onDelete(perform: removeBusinessItem)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(personalExpenses: personalExpenses, businessExpenses: businessExpenses)
            }
        }
    }
    func removePersonalItem(at offsets: IndexSet) {
        personalExpenses.items.remove(atOffsets: offsets)
    }
    
    func removeBusinessItem(at offsets: IndexSet) {
        businessExpenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

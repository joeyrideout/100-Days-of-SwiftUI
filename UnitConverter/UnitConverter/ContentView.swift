//
//  ContentView.swift
//  UnitConverter
//
//  Created by Joey Rideout on 2023-06-09.
//

import SwiftUI

struct ContentView: View {

    @State private var inputUnit = "ml"
    @State private var outputUnit = "cups"
    @State private var inputAmount = 0.0
    @FocusState private var inputAmountIsFocused: Bool
    
    let volumeUnits = ["ml", "L", "cups", "tea spoons", "Table spoons", "gallons", "pints"].sorted()
    
    var inputMl: Double {
        var inputMl: Double
        switch inputUnit {
        case "L":
            inputMl = inputAmount * 1000.0
        case "cups":
            inputMl = inputAmount * 250.0
        case "tea spoons":
            inputMl = inputAmount * 4.92892
        case "Table spoons":
            inputMl = inputAmount * 14.7868
        case "gallons":
            inputMl = inputAmount * 4546.1008287864
        case "pints":
            inputMl = inputAmount * 568.26260359829996105
        default:
            inputMl = inputAmount
        }
        return inputMl
    }
    
    var outputAmount: Double {
        switch outputUnit {
        case "L":
            return inputMl / 1000.0
        case "cups":
            return inputMl / 250.0
        case "tea spoons":
            return inputMl / 4.92892
        case "Table spoons":
            return inputMl / 14.7868
        case "gallons":
            return inputMl / 4546.1008287864
        case "pints":
            return inputMl / 568.26260359829996105
        default:
            return inputMl
        }
    }
    
    var outputStr: String {
        return String(format: "%.2f", outputAmount)
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", value: $inputAmount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputAmountIsFocused)
                    
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(volumeUnits, id: \.self) {
                            Text("\($0)")
                        }
                    }
                }
                
                Section {
                    Picker("Convert to", selection: $outputUnit) {
                        ForEach(volumeUnits, id: \.self) {
                            Text($0)
                        }
                    }
                    HStack {
                        Text("=")
                        Spacer()
                        Text("\(outputStr) \(outputUnit)")
                    }
                }
            }
            .navigationTitle("Unit Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputAmountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

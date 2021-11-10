//
//  ContentView.swift
//  WeSplit
//
//  Created by Phillip Park on 11/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var tipsPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    // Calculates the total per person
    // returns double
    var totalPerPerson: Double {
        let peopleCount: Double = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // returns value into a String
    var totalPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: grandTotal)) ?? "$0"

    }
    
    // calculates total price
    // returns double
    var grandTotal: Double {
        let tipSelection: Double = Double(tipsPercentage)
    
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var currencyType: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currencyCode ?? "USD")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currencyType)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Check Amount")
                }
                
                Section {
                    Picker("Tip Percentage", selection: $tipsPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("Tip Amount")
                }
                
                Section {
                    Text("\(totalPrice)")
                } header: {
                    Text("Grand Total Including Tip")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyType)
                    
                } header: {
                    Text("Amount Per Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  WeSplit
//
//  Created by Juan Ariza on 11/10/25.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercentage = 2
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: Double{
        let peopleCount = Double(numPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalCheckAmount: Double{
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationStack{
        Form{
            Section{
                TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                // first value "Amount" is a place holder in case it dont load
                // second value is where the input is being attached to #two way binding
                // 3rd controls hwo things are seen on the screen
                Picker("Number of Poeple", selection: $numPeople){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Section("How much would you like to Tip?"){
                
                Picker("Tip Percentage", selection: $tipPercentage){
                    ForEach(0..<101){
                        Text($0, format: .percent)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            Section("Total Check Amount:"){
                Text(totalCheckAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
            }
            
            Section("Amount Per Person:"){
                Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

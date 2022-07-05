//
//  ContentView.swift
//  WeSplit
//
//  Created by Daniel Spalek on 05/07/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage = 10
    @FocusState private var amountIsFocused: Bool // used to know if we are focused on something that should be using keyboard
    
    let tipPercentages = [0, 5, 10, 15, 20, 25, 30, 35]
    
    var totalPerPerson: Double {
        // computed property - calculate total per person
        let peopleCount = Double(numberOfPeople + 1)
        let tipSelection = Double(tipPercentage)
        
        let tipValue: Double = checkAmount * tipSelection / 100
        let grandTotal: Double = checkAmount + tipValue
        let amountPerPerson: Double = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "ILS"))
                        .keyboardType(.decimalPad) // we only want to be able to enter decimals. That does not stop the user from entering text though, as he can copy-paste or use an actualy keyboard connected to his device to type. but because we set the format to currency, swift will handle this automatically.
                    // Locale.current - a locale representing the user's region
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(1..<99) { number in
                            Text("\(number) people")
                        }
                    }
                } header: {
                    Text("Amount and number of people")
                }
                Section{
//                    Text("Tip Percentage: \(tipPercentage)%")
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self){ num in
                            Text(num, format: .percent)
                        }
                    }
                    .pickerStyle(.wheel)
                    TextField("Enter Manually", value: $tipPercentage, format: .percent)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                } header: {
                    Text("select tip percentage or enter manually")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "ILS"))
                } header: {
                    Text("Total per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar(.visible)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
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

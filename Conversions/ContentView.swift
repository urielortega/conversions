//
//  ContentView.swift
//  Conversions
//
//  Created by Uriel Ortega on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var input = 0.0
    @State private var output = 111.0

    @State private var inputUnit = UnitLength.meters
    @State private var outputUnit = UnitLength.kilometers
    
    @FocusState private var inputIsFocused: Bool
    
    let units: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)

        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                        .font(.system(size: 40, weight: .medium))
                        .padding()
                } header: {
                    Text("Amount to convert")
                }
                
                Picker("From", selection: $inputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Output unit", selection: $outputUnit) {
                    ForEach(units, id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Section {
                    Text(result)
                        .font(.system(size: 40, weight: .bold))
                        .padding()
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Conversions")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

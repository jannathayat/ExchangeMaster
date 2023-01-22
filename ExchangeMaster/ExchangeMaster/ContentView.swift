//
//  ContentView.swift
//  ExchangeMaster
//
//  Created by Jannat Hayat on 1/21/23.
//


// https://api.exchangerate.host/latest?base=\(base)&amount=\(input)
import SwiftUI

struct ContentView: View {
    @State var input = "100"
    @State var base = "USD"
    @State var currencyList = [String]()
    @FocusState private var inputIsFocused: Bool
    
    func makeRequest(showAll: Bool, currencies: [String] = ["USD", "GBP", "EUR"]){
        apiRequest(url: "https://api.exchangerate.host/latest?base=\(base)&amount=\(input)") { currency in
            var tempList = [String]()
            
            for currency in currency.rates {
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                } else if currencies.contains(currency.key){
                    tempList.append("\(currency.key) \(String(format: "%.2f", currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            print(tempList)
        }
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Currencies")
                    .font(.largeTitle)
                    .font(.system(size: 30))
                    .bold()
                    .italic()
                Image(systemName: "eurosign.circle.fill")
                    .font(.system(size: 40))
                    .foregroundColor(.green)
            }
            List {
                ForEach(currencyList, id: \.self) { Currency in
                    Text(Currency)
                }
            }
            VStack {
                Rectangle()
                    .frame(height: 15.0)
                    .foregroundColor(.green)
                    .opacity(0.90)
                TextField("Enter your Amount", text: $input)
                    .padding()
                    .background(Color.green.opacity(0.25))
                    .cornerRadius(100.0)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                
                TextField("Enter a currency", text: $base)
                    .padding()
                    .background(Color.green.opacity(0.25))
                    .cornerRadius(100.0)
                    .padding()
                    .focused($inputIsFocused)
                
                Button("Exchange") {
                    makeRequest(showAll: true)
                    inputIsFocused =  false
                }.padding()
                
                
            }
        } .onAppear {
            makeRequest(showAll: true)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

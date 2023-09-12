//
//  ContentView.swift
//  CountryCities
//
//  Created by Sarthak Agrawal on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = CountryViewModel()
    
    @State private var selectedCountry = "USA"
    var body: some View {
        NavigationView {
            Form{
                Picker("Country", selection: $selectedCountry){
                    ForEach(viewModel.countries, id: \.country) { country in
                        Text(country.country)
//                        Text()
                    }
                }
                
                NavigationLink(destination: CitiesView(cities: viewModel.countries.first(where: { $0.country == selectedCountry })?.cities ?? [])) {
                    Text("Show Cities")
                }
            }
            .onAppear {
                viewModel.fetchCountry()
            }
            .navigationTitle("Select a Country")
        }
    }
}

struct CitiesView: View {
    let cities: [String]
    
    var body: some View {
        List(cities, id: \.self) { city in
            Text(city)
        }
        .navigationTitle("Cities")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


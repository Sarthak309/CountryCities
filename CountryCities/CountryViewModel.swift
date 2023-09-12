//
//  CountryModel.swift
//  CountryCities
//
//  Created by Sarthak Agrawal on 12/09/23.
//

import Foundation

struct CountryResponse: Codable {
    let data: [Country]
}

struct Country: Codable {
    let country: String
    let cities: [String]
}

// ViewModel
class CountryViewModel: ObservableObject {
    @Published var countries = [Country]()
    
    func fetchCountry() {
        let url = URL(string: "https://countriesnow.space/api/v0.1/countries")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(CountryResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.countries = decodedResponse.data
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}


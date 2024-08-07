//
//  LocalDataManager.swift
//  Football Daily
//
//  Created by Thomas Mani on 03/08/24.
//

import Foundation

class LocalDataManager {
    static let shared = LocalDataManager()
    
    enum Filename: String {
    case countries = "countries"
    }
    
    private func writeData(_ data: Codable, filename: String) -> Void {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(filename).json")
            
            try JSONEncoder()
                .encode(data)
                .write(to: fileURL)
        } catch {
            print("error writing data")
        }
    }
    
    private func readData<T: Codable>(filename: String) -> T? {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("\(filename).json")
            
            let data = try Data(contentsOf: fileURL)
            let pastData = try JSONDecoder().decode(T.self, from: data)
            
            return pastData
        } catch {
            print("error reading data")
            return nil
        }
    }
    
    func writeCountriesData(countries: [Country]) {
        writeData(countries, filename: Filename.countries.rawValue)
    }
    
    func readCountriesData() -> [Country] {
        let countries: [Country]? = readData(filename: Filename.countries.rawValue)
        return countries ?? []
    }
}

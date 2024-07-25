//
//  Encodable+Extension.swift
//  Football Daily
//
//  Created by Thomas Mani on 25/07/24.
//

import Foundation

extension Encodable {
  func asDictionary() throws -> [String: String] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: String] else {
      throw NSError()
    }
    return dictionary
  }
}

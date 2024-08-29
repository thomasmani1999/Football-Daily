//
//  String+Extension.swift
//  Football Daily
//
//  Created by Thomas Mani on 21/08/24.
//

import Foundation

extension String {
    func flag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
}

//
//  View+Extension.swift
//  Football Daily
//
//  Created by Thomas Mani on 07/08/24.
//

import Foundation
import SwiftUI

extension View {
    func NeumorphicStyle() -> some View {
        self
            .background(Color.backgroundGrey)
            .cornerRadius(20)
            .shadow(color: Color.white.opacity(0.2), radius: 10, x: -5, y: -5)
            .shadow(color: Color.black.opacity(0.7), radius: 10, x: 10, y: 10)
    }
}

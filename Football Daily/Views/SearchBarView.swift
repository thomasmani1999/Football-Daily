//
//  SearchBarView.swift
//  Football Daily
//
//  Created by Thomas Mani on 09/08/24.
//

import Foundation
import SwiftUI

protocol SearchBarDelegate {
    func searchFor(text: String)
}

struct SearchBarView<T: SearchBarDelegate & ObservableObject>: View {
    
    @State var input: String = ""
    @ObservedObject var model: T
    var placeholder: String
    
    var body: some View {
        HStack(spacing: .zero) {
            HStack(spacing: .zero) {
                Image(systemName: "magnifyingglass")
                    .padding(5)
                
                TextField("Search \(placeholder)", text: $input)
                    .onChange(of: input, { oldValue, newValue in
                        model.searchFor(text: newValue)
                    })
            }
            .background(.white)
            .cornerRadius(20)
            
            Spacer()
            
            if !input.isEmpty {
                Button("Cancel") {
                    withAnimation {
                        input = ""
                    }
                }
                .transition(.slide)
                .tint(.white)
                .font(.body)
                .padding(.leading, 10)
            }
        }
        .padding(15)
    }
}

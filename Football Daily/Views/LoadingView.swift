//
//  LoadingView.swift
//  Football Daily
//
//  Created by Thomas Mani on 29/07/24.
//

import SwiftUI

struct LoadingView: View {
    
    @State var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.clear)
                .ignoresSafeArea()
            VStack(content: {
                Image(systemName: "soccerball")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70)
                    .colorInvert()
                    .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                    .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isLoading)
                
                Text("Loading ...")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            })
            .onAppear() {
                isLoading.toggle()
            }
        }
        .allowsHitTesting(false)
    }
}

#Preview {
    LoadingView()
        .background(
            .linearGradient(
                .init(colors: [.blue,.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing))
}

//
//  Football_DailyApp.swift
//  Football Daily
//
//  Created by Thomas Mani on 24/07/24.
//

import SwiftUI
import SDWebImage
import SDWebImageSVGCoder

@main
struct Football_DailyApp: App {
    
    init() {
        setUpDependencies() // Initialize SVGCoder
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}

private extension Football_DailyApp {
    
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
    }
}

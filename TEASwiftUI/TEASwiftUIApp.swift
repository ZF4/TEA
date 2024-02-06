//
//  TEASwiftUIApp.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 4/6/23.
//

import SwiftUI
import SwiftData

@main
struct TEASwiftUIApp: App {
    @AppStorage("isFirstTimeLaunch") private var isFirstTimeLaunch: Bool = true
    @AppStorage("isOnboarding") private var isOnboarding = true
    @State private var splashScreenIsPresented = true
    @StateObject var taskViewModel: CardViewModel = CardViewModel()
    @StateObject var quoteViewModel: QuoteViewModel = QuoteViewModel()
    @StateObject var visionModel: VisionModel = VisionModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if isOnboarding {
                    ContentView()
                } else {
                    if splashScreenIsPresented {
                        SplashScreenView {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    splashScreenIsPresented = false
                                }
                            }
                        }
                    } else {
                        CardView()
                            .modelContainer(for: [TaskModel.self, TextModel.self])
                    }
                }
            }
            .environmentObject(taskViewModel)
            .environmentObject(quoteViewModel)
            .environmentObject(visionModel)
        }
    }
}

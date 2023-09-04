//
//  TEASwiftUIApp.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 4/6/23.
//

import SwiftUI

@main
struct TEASwiftUIApp: App {
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @StateObject var textViewModel: TextViewModel = TextViewModel()
    @StateObject var quoteViewModel: QuoteViewModel = QuoteViewModel()
    @StateObject var visionModel: VisionModel = VisionModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CardView()
            }
            .environmentObject(taskViewModel)
            .environmentObject(textViewModel)
            .environmentObject(quoteViewModel)
            .environmentObject(visionModel)
        }
    }
}

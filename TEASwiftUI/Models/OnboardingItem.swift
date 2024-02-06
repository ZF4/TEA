//
//  FirstTimePopUp.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 11/7/23.
//

import Foundation

struct OnboardingItem: Identifiable, Equatable {
    let id = UUID()
    let image: String
    let title: String
    let description: String
    var tag: Int
    
    static var pages = [OnboardingItem(image: "newTea", title: "I'm happy you're here!", description: "Welcome to the TEA App. This app is designed to help you focus on where to place your Time, Energy, and Attention. The app will have three sections: Tasks, Gratefuls, and Rocks.", tag: 0),
                        OnboardingItem(image: "taskImage", title: "Task Section", description: "The Task section is fairly self-explanatory. Create something you need to do today and specify the time you plan to do it.", tag: 1),
                        OnboardingItem(image: "gratefulImage", title: "Grateful Section", description: "The Grateful section is where you can take a moment to stare at your screen and reflect on all the things that you are truly grateful for. (There's more than you think)", tag: 2),
                        OnboardingItem(image: "rockImage", title: "Rock Section", description: "Lastly, we have the Rock section. These are items you should really focus on. Think about large goals you can break down: exercising, finishing a paper, applying for that new job, etc. If you're able to complete all your rocks, allow yourself to be okay if you didn't finish some tasks today. Be proud of yourself for moving those Rocks!", tag: 3)
    ]
}

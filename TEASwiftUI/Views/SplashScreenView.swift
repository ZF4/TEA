//
//  SplashScreenView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 1/22/24.
//

import SwiftUI

struct SplashScreenView: View {
    var loadingTask: () -> ()
    @State private var pulsingAnimation: Bool = false
    var body: some View {
        ZStack {
            Image("newTea")
                .resizable()
                .frame(width: 250, height: 250)
                .opacity(pulsingAnimation ? 1.0 : 0.4)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                        pulsingAnimation.toggle()
                    }
                    loadingTask()
                }
        }
    }
}

#Preview {
    SplashScreenView(loadingTask: {})
}

//
//  FirstLoginView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 1/15/24.
//

import SwiftUI

struct OnboardingView: View {
    var page: OnboardingItem
    
    var body: some View {
        VStack {
            Image(page.image)
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 200)
            VStack {
                Text(page.title)
                    .font(.title)
                    .bold()
                    .padding(.bottom)
                
                Text(page.description)
                    .font(.headline)
                    .multilineTextAlignment(.center)
            }
            .padding(.horizontal)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var item1 = OnboardingItem(image: "rockImage", title: "Test", description: "testing with a lot of words, yes keep tesitng yesndns dk.", tag: 0)
    
    static var previews: some View {
        OnboardingView(page: item1)
    }
}

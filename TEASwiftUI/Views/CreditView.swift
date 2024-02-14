//
//  InfoView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 1/23/24.
//

import SwiftUI

struct CreditView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var showCredits: Bool
    var body: some View {
        VStack {
            Text("Credits:")
                .font(.title)
                .fontWeight(.bold)
                .padding(.vertical)
            VStack(alignment: .leading) {
                
                HStack {
                    Text("Lacy Gunnoe").bold()
                    + Text("- Great mentor and mastermind behind the TEA concept.")
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("Ed Farm").bold()
                    + Text("- For the opprotunity to learn and grow.")
                    
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("Alandis Seals, David Douglas, and Craig Clayton").bold()
                    + Text("- For all of the support.")
                }
                .padding(.bottom, 5)
                
                HStack {
                    Text("Halie Farmer").bold()
                    + Text("- My wife who was the best rubber duck that helped me work through all of my challenges. I love you.")
                }
                .padding(.bottom, 5)
                
                Text("Inspirational quotes provided by [ZenQuotes API](https://zenquotes.io/)")
                    .font(.system(size: 12))
                    .lineLimit(nil)
                    .padding(.bottom, 5)
                
                Text("All emojis designed by [OpenMoji](https://openmoji.org/) – the open-source emoji and icon project. License: [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/#)")
                    .font(.system(size: 12))
                    .lineLimit(nil)
                    .padding(.bottom, 5)
                
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button("Close") {
                showCredits.toggle()
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom)
        }
        .frame(width: 350, height: 450)
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    CreditView(showCredits: .constant(true))
}

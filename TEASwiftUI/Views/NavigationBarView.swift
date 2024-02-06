//
//  NavigationBarView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 1/31/24.
//

import SwiftUI

struct NavigationBarView: View {
    var body: some View {
        HStack {
            Button(action: {}, label: {
                Image(systemName: "ellipsis")
                    .font(.title)
            })
            
            Spacer()
            Text("TEA")
                .font(.system(size: 30))
                .font(.title3)
                .fontWeight(.black)
            Spacer()
            
            Button(action: {}, label: {
                Image(systemName: "info.circle")
                    .font(.title)
            })
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    NavigationBarView()
        .padding()
}

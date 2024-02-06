//
//  GratefulModel.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 10/6/23.
//

import Foundation
import SwiftData

@Model
class TextModel: Identifiable {
    @Attribute(.unique) let id: String
    let title: String
    let textType: String
    
    init(id: String = UUID().uuidString, title: String, textType: String) {
        self.id = id
        self.title = title
        self.textType = textType
    }
}

extension TextModel {
    
    static var defaults: [TextModel] {
        [
            .init(title: "Family 🏠", textType: "grateful"),
            .init(title: "Drink Water 💦", textType: "rock")
        ]
    }
}





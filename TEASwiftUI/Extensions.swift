//
//  Extensions.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 8/24/23.
//

import Foundation
import SwiftUI

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
}

extension Date {
    func localTimeString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.locale = Locale(identifier: "en-US")
            let finalTimeString = dateFormatter.string(from: self)
        return finalTimeString
    }
}

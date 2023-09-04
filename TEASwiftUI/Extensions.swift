//
//  Extensions.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 8/24/23.
//

import Foundation

extension String {
    var capitalizedSentence: String {
        let firstLetter = self.prefix(1).capitalized
        let remainingLetters = self.dropFirst().lowercased()
        
        return firstLetter + remainingLetters
    }
}

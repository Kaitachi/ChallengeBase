//
//  Challenge.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-04.
//

import Foundation

protocol Challenge {
    static var basePath: String { get }
    
    static var name: String { get }
}

extension Challenge {
    static var basePath: String {
        get {
            return #file.replacingOccurrences(of: "Source/Protocols/Challenge.swift", with: "Resources/\(self.name)")
        }
    }
}

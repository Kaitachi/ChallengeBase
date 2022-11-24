//
//  Challenge.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-04.
//

import Foundation

protocol Challenge {
    // MARK: - Associated Types
    associatedtype Algorithms: RawRepresentable & CaseIterable where Algorithms.RawValue: StringProtocol
    
    // MARK: - Properties
    /// Base path for current Challenge
    var baseResourcePath: String { get }
    
    /// Current Challenge name
    var name: String { get }
}

extension Challenge {
    var baseResourcePath: String {
        get {
            return #file.replacingOccurrences(of: "Source/Protocols/Challenge.swift", with: "Resources/\(self.name)")
        }
    }
}

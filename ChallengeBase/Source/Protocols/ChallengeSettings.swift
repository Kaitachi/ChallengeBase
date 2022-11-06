//
//  ChallengeSettings.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-04.
//

import Foundation

protocol ChallengeSettings {
    associatedtype algorithms: RawRepresentable where algorithms.RawValue: StringProtocol

    static var basePath: String { get }
    
    static var challengeName: String { get }
}

extension ChallengeSettings {
    static var basePath: String {
        get {
            return #file.replacingOccurrences(of: "Source/Protocols/ChallengeSettings.swift", with: "Resources")
        }
    }
}

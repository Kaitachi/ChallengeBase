//
//  Challenge.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-04.
//

import Foundation

public protocol Challenge {
    // MARK: - Associated Types
    associatedtype Algorithms: RawRepresentable & CaseIterable where Algorithms.RawValue: StringProtocol
    associatedtype Solutions: RawRepresentable & CaseIterable where Solutions.RawValue: StringProtocol
    
    // MARK: - Properties
    /// Base path for current Challenge
    var baseResourcePath: String { get }
    
    // MARK: - Methods
    static func create(_ solution: Solutions) -> any Solution
}

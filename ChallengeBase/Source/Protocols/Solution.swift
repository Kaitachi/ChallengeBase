//
//  Solution.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-10-29.
//

import Foundation

protocol Solution {
    associatedtype Input
    associatedtype Output: Equatable
    typealias TestCase = (input: Input, output: Output?)
    typealias TestResult = (input: Input, expectedOutput: Output?, actualOutput: Output, isSuccessful: Bool)

    /// Collection of Test Cases for this Solution
    var testCases: [TestCase] { get set }
    
    /// Receives Test Case data from input and (optional) output files and transforms them into TestCase objects (easier to act upon)
    func arrange(_ input: String, _ output: String?)
    
    /// Performs a single Run
    func act(_ input: Input) -> Output
    
    /// Performs all Tests
    func assert() -> [TestResult]
}

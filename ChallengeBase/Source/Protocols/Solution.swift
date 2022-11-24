//
//  Solution.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-10-29.
//

import Foundation

protocol Solution : Challenge {
    // MARK: - Associated Types
    associatedtype Input
    associatedtype Output: Equatable
    
    // MARK: - Properties
    /// Collection of Test Cases to be performed for this Solution
    var testCases: [TestCase<Input, Output>] { get set }
    
    /// Collection of DataSets to be used for testing against
    var selectedResourceSets: [String] { get set }
    
    /// Collection of Algorithms to be executed on top of our datasets
    var selectedAlgorithms: [Algorithms] { get set }
    
    // MARK: - Solution Methods
    /// Receives Test Case data from input and (optional) output files and transforms them into TestCase objects (easier to act upon)
    func assemble(_ input: String, _ output: String?) -> (Input, Output?)
    
    /// Performs a single Run
    func act(_ input: Input, algorithm: Algorithms) -> Output
    
    // MARK: - Extension Methods
    
}

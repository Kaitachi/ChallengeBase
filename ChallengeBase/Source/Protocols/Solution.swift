//
//  Solution.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-10-29.
//

import Foundation

protocol Solution {
    associatedtype Algorithms: RawRepresentable & CaseIterable where Algorithms.RawValue: StringProtocol
    associatedtype Input
    associatedtype Output: Equatable

    /// Collection of Test Cases to be performed for this Solution
    var datasets: [TestCase<Input, Output>] { get set }
    
    /// Receives Test Case data from input and (optional) output files and transforms them into TestCase objects (easier to act upon)
    func assemble(_ input: String, _ output: String?) -> (Input, Output?)
    
    /// Performs a single Run
    func act(_ input: Input, algorithm: Algorithms) -> Output
    
    /// Collection of DataSets to be used for testing against
    var selectedDatasets: [String] { get set }
    
    /// Collection of Algorithms to be executed on top of our datasets
    var selectedAlgorithms: [Algorithms] { get set }
}

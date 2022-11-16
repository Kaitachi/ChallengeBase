//
//  TestCase.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-06.
//

import Foundation

protocol Testable {
    associatedtype Input
    associatedtype Output: Equatable
    
    var input: Input { get }
    var output: Output? { get set }
    
    var expectedOutput: Output? { get }
    var actualOutput: Output? { get set }
    
    var isSuccessful: Bool { get }
}

struct TestCase<Input, Output> : Testable where Output : Equatable {
    var algorithm: any RawRepresentable
    var input: Input
    var output: Output?
    var actualOutput: Output?

    var expectedOutput: Output? {
        get { return self.output }
    }
        
    var isSuccessful: Bool {
        get { return self.expectedOutput == actualOutput }
    }
}

//
//  TestCase.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-06.
//

import Foundation

public protocol Testable {
    // MARK: - Associated Types
    associatedtype Input
    associatedtype Output: Equatable
    
    // MARK: - Properties
    var name: String { get set }
    var input: Input { get }
    var output: Output? { get set }
    
    var expectedOutput: Output? { get }
    var actualOutput: Output? { get set }
    
    var isSuccessful: Bool { get }
}

public struct TestCase<Input, Output> : Testable where Output : Equatable {
    public var name: String
    public var algorithm: any RawRepresentable
    public var input: Input
    public var output: Output?
    public var actualOutput: Output?

    public var expectedOutput: Output? {
        get { return self.output }
    }
        
    public var isSuccessful: Bool {
        get { return self.expectedOutput == actualOutput }
    }
}

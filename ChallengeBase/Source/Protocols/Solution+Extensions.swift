//
//  Solution+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-05.
//

import Foundation

extension Solution where Self: ChallengeSettings & Solution {
    static var solution: String {
        get { return String(describing: self) }
    }
    
    func assert() -> [TestResult] {
        let testResults = self.testCases
            .map { testCase in
                (test: testCase, result: self.act(testCase.input))
                
            }
            .map { testCase in
                (input: testCase.test.input,
                 expectedOutput: testCase.test.output,
                 actualOutput: testCase.result,
                 isSuccessful: testCase.test.output == testCase.result
                )
            }
        
        return testResults
    }
    
    func readFile(scenario: String?, isTest: Bool = true) {
        let currentScenario = (isTest && scenario != nil) ? ".\(scenario!)" : ""
        let relativePath = "\(Self.challengeName)/\(Self.solution)\(currentScenario)"
        let path = "\(Self.basePath)/\(relativePath)"
        
        print("> Reading files for \(relativePath)...")
        
        do {
            let fileManager = FileManager.default
            
            var input: String? = nil
            var output: String? = nil
            
            // Validate and read input file
            guard fileManager.fileExists(atPath: "\(path).in") else {
                print("Input file is missing! Aborting execution...")
                return
            }

            input = try String(contentsOfFile: "\(path).in", encoding: .utf8)
                .trimmingCharacters(in: .whitespacesAndNewlines)

            // Validate and read output file
            if fileManager.fileExists(atPath: "\(path).out") {
                output = try String(contentsOfFile: "\(path).out", encoding: .utf8)
                    .trimmingCharacters(in: .whitespacesAndNewlines)
            } else if isTest {
                print("> Output file is missing!")
            }
            
            self.arrange(input!, output)
        }
        catch let error as NSError {
            print("> Something went wrong while reading files: \(error)")
        }
    }
    
    
    mutating func execute(scenarios: [String]?) {
        var passedAllScenarios = true
        
        if let scenarios = scenarios {
            for scenario in scenarios {
                passedAllScenarios = passedAllScenarios && self.runTest(scenario: scenario)
            }
        }
        
        if passedAllScenarios {
            self.solve()
        } else {
            print("Skipped solution execution! Test cases failed.")
        }
    }
    
    mutating func runTest(scenario: String) -> Bool {
        // Step 1: Arrange data
        self.readFile(scenario: scenario)
        
        // Step 2: Act (with assertion within)
        let assertion = self.assert()[0]

        // Step 3: Assert (by showing unit test results)
        if assertion.isSuccessful {
            print("Test \(scenario) executed successfully!")
        } else {
            print("Something went wrong with test \(scenario)...")
            print("Test data:")
            print(assertion.input)
            print("Expected \(String(describing: assertion.expectedOutput)), got \(assertion.actualOutput)")
        }
        
        self.testCases.removeAll()
        
        return assertion.isSuccessful
    }
    
    func solve() {
        // Step 1: Arrange data
        self.readFile(scenario: nil, isTest: false)
        
        // Step 2: Act
        let solution = self.act(self.testCases[0].input)
                
        // Step 3: Assert (if tests were executed successfully, this should be correct)
        print("Solution is: \(solution)")
    }
}

//
//  Solution.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-10-29.
//

import Foundation

enum ResourceExtensions : String {
    case input = "in"
    case output = "out"
}

public protocol Solution : Challenge {
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
    func assemble(_ rawInput: String, _ rawOutput: String?) -> (Input, Output?)
    
    /// Performs a single Run
    func activate(_ input: Input, algorithm: Algorithms) -> Output
    
    // MARK: - Extension Methods
    /// Executes all configured Test Cases and Algorithms (plus actual solve, if test cases are successful)
    mutating func execute()
    
    /// Outputs the solution to the given Algorithm
    func solve(algorithm: Algorithms)
    
    // MARK: - Helper Methods
    mutating func setResourceSets(_ resources: [String])
    
    mutating func setAlgorithms(_ algorithms: [Algorithms])
}

public extension Solution where Self: Challenge & Solution {
    // MARK: - Computed Properties
    var solution: String {
        get { return String(describing: type(of: self)) }
    }
    
    // MARK: - Helper Methods
    mutating func setResourceSets(_ resources: [String]) {
        self.selectedResourceSets = resources
    }
    
    mutating func setAlgorithms(_ algorithms: [Algorithms]) {
        self.selectedAlgorithms = algorithms
    }
    
    // MARK: - Assemble Methods
    /// Logic to assemble all scenarios parting from the selected datasets, broken down one by one
    mutating func assembleAll(algorithm: Algorithms) {
        self.selectedResourceSets.forEach { dataset in
            self.testCases.append(assembleSingle(dataset, algorithm)!)
        }
    }
    
    mutating func assembleSingle(_ dataset: String, _ algorithm: Algorithms) -> TestCase<Input, Output>? {
        do {
            // Read relevant Dataset
            let inputData = try readDataSet(type: .input, named: dataset, algorithm: algorithm)
            let outputData = try readDataSet(type: .output, named: dataset, algorithm: algorithm)
            
            let assembled = assemble(inputData, outputData)
        
            // Wrap assembled Dataset as a TestCase object
            return TestCase<Input, Output>(name: dataset, algorithm: algorithm, input: assembled.0, output: assembled.1)
        } catch let error as NSError {
            print("Something went wrong whilst attempting to assemble scenarios... \(error)")
            return nil
        }
    }
    
    internal func readDataSet(type: ResourceExtensions, named dataset: String? = nil, algorithm: Algorithms? = nil) throws -> String {
        // Lets assume the following regarding the files being used...
        //
        // 1. File formats should be:
        //    a. for input file:    `<solution>[.<dataset>][.<algorithm>].in`
        //
        //    b. for output file:   `<solution>[.<dataset>][.<algorithm>].out`
        //
        // 2. Whenever dataset and algorithm is not provided for input files,
        //      we fall back to using the default `<solution>.in` file
        //
        // Determine full file name
        
        // File name parts
        var resourceFile: [String] = [
            self.solution,
            (!(dataset?.trimmingCharacters(in: .whitespaces).isEmpty ?? true)) ? String(describing: dataset!) : "",
            (algorithm != nil) ? String(describing: algorithm!) : "",
            type.rawValue
        ]
            
        do {
            let fileSystem = FileManager.default
           
            // Validate and read file
            while (!fileSystem.fileExists(atPath: "\(self.baseResourcePath)/\(resourceFile.asResourceName)") && resourceFile.count > 1) {
//                print("file >\(self.baseResourcePath)/\(resourceFile.asResourceName)< does not exist")
                
                resourceFile.remove(at: resourceFile.count - 2)
            }
            
//            print("Reading file >\(self.baseResourcePath)/\(resourceFile.joined(separator: "."))<")
            return try String(contentsOfFile: "\(self.baseResourcePath)/\(resourceFile.asResourceName)")
        } catch let error as NSError {
            print("Something went wrong while reading file \(resourceFile.asResourceName)! \(error)")
            throw error
        }
    }
    
    // MARK: - Activate Methods
    mutating func activateAll() {
        for (index, test) in self.testCases.enumerated() {
            self.testCases[index].actualOutput = self.activate(test.input, algorithm: test.algorithm as! Self.Algorithms)
        }
    }
    
    // MARK: - Assert Methods
    func assertAll() -> Bool {
        return self.testCases
            .map { $0.expectedOutput == $0.actualOutput }
            .allSatisfy { $0 }
    }
    
    mutating func execute() {
        if selectedAlgorithms.count == 0 {
            selectedAlgorithms = Array(Algorithms.allCases)
        }
        
        self.selectedAlgorithms.forEach { algorithm in
            print("Running \(String(describing: self)) using algorithm \(algorithm)...")
            
            self.testCases = []
            
            // Step 1: Assemble
            self.assembleAll(algorithm: algorithm)
            
//            print(self.datasets)
            
            // Step 2: Activate
            self.activateAll()
            
//            print(self.datasets)
            
            // Step 3: Assert
            let isSuccessfulTests = self.assertAll()
            
            if isSuccessfulTests {
                if self.testCases.count == 0 {
                    print("No Test Cases were provided! Executing real data...")
                } else {
                    print("Test Cases executed successfully! Executing real data...")
                }

                self.solve(algorithm: algorithm)
            } else {
                print("Skipped solution execution! Test cases failed:")
                
                self.testCases.forEach { dataset in
                    if !dataset.isSuccessful {
                        print("Using Algorithm \(dataset.algorithm), Test Case \(dataset.name)")
                        print("Expected ", terminator: "")
                        printSolution(for: dataset.expectedOutput!)
                        print()
                        print("Got ", terminator: "")
                        printSolution(for: dataset.actualOutput!)
                    }
                }
            }
            
            print()
        }
    }
    
    func solve(algorithm: Algorithms) {
        do {
            // Step 1: Assemble
            let inputData = try readDataSet(type: .input)
            let assembled = assemble(inputData, nil)
            
            // Step 2: Activate
            let result = self.activate(assembled.0, algorithm: algorithm)
            
            // Step 3: Assert (show result)
            print("> Using algorithm \(algorithm), output: ", terminator: "")
            printSolution(for: result)
        } catch let error as NSError {
            print("Something went wrong with the actual scenario... \(error)")
        }
    }
    
    func printSolution(for output: Output) {
        if let array = output as? Array<Any> {
            print()
            
            for line in array {
                print("\t\t \(line)")
            }
        } else {
            print(output)
        }
    }
}

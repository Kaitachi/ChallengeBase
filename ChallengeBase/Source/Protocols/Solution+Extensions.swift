//
//  Solution+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-05.
//

import Foundation

enum ResourceExtensions : String {
    case input = "in"
    case output = "out"
}

extension Solution where Self: Challenge & Solution {
    var qualifiedName: String {
        get { return "\(Self.name).\(String(describing: Self.self))" }
    }
    
    var solution: String {
        get { return String(describing: Self.self) }
    }
    
    /// Logic to assemble all scenarios parting from the selected datasets, broken down one by one
    mutating func assembleAll(algorithm: Algorithms) {
        self.selectedDatasets.forEach { dataset in
            self.datasets.append(assembleSingle(dataset, algorithm)!)
        }
    }
    
    mutating func assembleSingle(_ dataset: String, _ algorithm: Algorithms) -> TestCase<Input, Output>? {
        do {
            // Read relevant Dataset
            let inputData = try readDataSet(type: .input, named: dataset, algorithm: algorithm)
            let outputData = try readDataSet(type: .output, named: dataset, algorithm: algorithm)
            
            let assembled = assemble(inputData, outputData)
        
            // Wrap assembled Dataset as a TestCase object
            return TestCase<Input, Output>(algorithm: algorithm, input: assembled.0, output: assembled.1)
        } catch let error as NSError {
            print("Something went wrong whilst attempting to assemble scenarios... \(error)")
            return nil
        }
    }
    
    func readDataSet(type: ResourceExtensions, named dataset: String? = nil, algorithm: Algorithms? = nil) throws -> String {
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
            while (!fileSystem.fileExists(atPath: "\(Self.basePath)/\(resourceFile.asResourceName)") && resourceFile.count > 1) {
//                print("file >\(Self.basePath)/\(resourceFile.asResourceName)< does not exist")
                
                resourceFile.remove(at: resourceFile.count - 2)
            }
            
//            print("Reading file >\(Self.basePath)/\(resourceFile.joined(separator: "."))<")
            return try String(contentsOfFile: "\(Self.basePath)/\(resourceFile.asResourceName)")
        } catch let error as NSError {
            print("Something went wrong while reading file \(resourceFile.asResourceName)! \(error)")
            throw error
        }
    }
    
    mutating func actAll() {
        for (index, test) in self.datasets.enumerated() {
            self.datasets[index].actualOutput = self.act(test.input, algorithm: test.algorithm as! Self.Algorithms)
        }
    }
    
    func assertAll() -> Bool {
        return self.datasets
            .map { $0.expectedOutput == $0.actualOutput }
            .allSatisfy { $0 }
    }
    
    mutating func execute() {
        if selectedAlgorithms.count == 0 {
            selectedAlgorithms = Array(Algorithms.allCases)
        }
        
        self.selectedAlgorithms.forEach { algorithm in
            print("Running \(self.qualifiedName) using algorithm \(algorithm)...")
            
            self.datasets = []
            
            // Step 1: Assemble
            self.assembleAll(algorithm: algorithm)
            
//            print(self.datasets)
            
            // Step 2: Act
            self.actAll()
            
//            print(self.datasets)
            
            // Step 3: Assert
            let isSuccessfulTests = self.assertAll()
            
            if isSuccessfulTests {
                print("Tests executed successfully! Executing real data...")
                self.solve(algorithm: algorithm)
            } else {
                print("Skipped solution execution! Test cases failed:")
                
                self.datasets.forEach { dataset in
                    print("Expected \(dataset.expectedOutput!); got \(dataset.actualOutput!)")
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
            
            // Step 2: Act
            let result = self.act(assembled.0, algorithm: algorithm)
            
            // Step 3: Assert (show result)
            print("> Using algorithm \(algorithm), output: \(result)")
        } catch let error as NSError {
            print("Something went wrong with the actual scenario... \(error)")
        }
    }
}

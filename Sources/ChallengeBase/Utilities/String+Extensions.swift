//
//  String+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-24.
//

import Foundation

public extension String {
    func integerList(separatedBy itemSeparator: CharacterSet = .newlines) -> [Int] {
        return self.components(separatedBy: itemSeparator)
            .compactMap { Int($0) }
    }
    
    func integerArray2D(separatedBy rowSeparator: CharacterSet = .newlines, thenBy columnSeparator: CharacterSet = .whitespaces) -> [[Int]] {
        return self.components(separatedBy: rowSeparator)
            .filter { !$0.isEmpty }
            .compactMap { line in
                line.components(separatedBy: columnSeparator)
                    .compactMap { cell in Int(cell) }
            }
    }
    
    func doubleList(separatedBy itemSeparator: CharacterSet = .newlines) -> [Double] {
        return self.components(separatedBy: itemSeparator)
            .compactMap { Double($0) }
    }
    
    func doubleArray2D(separatedBy rowSeparator: CharacterSet = .newlines, thenBy columnSeparator: CharacterSet = .whitespaces) -> [[Double]] {
        return self.components(separatedBy: rowSeparator)
            .filter { !$0.isEmpty }
            .compactMap { line in
                line.components(separatedBy: columnSeparator)
                    .compactMap { cell in Double(cell) }
            }
    }
}

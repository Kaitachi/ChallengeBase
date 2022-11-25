//
//  String+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-24.
//

import Foundation

public extension String {
    func integerList(separatedBy: CharacterSet = .newlines) -> [Int] {
        return self.components(separatedBy: separatedBy)
            .compactMap { Int($0) }
    }
    
    func doubleList(separatedBy: CharacterSet = .newlines) -> [Double] {
        return self.components(separatedBy: separatedBy)
            .compactMap { Double($0) }
    }
}

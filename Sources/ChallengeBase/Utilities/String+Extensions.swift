//
//  String+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-24.
//

import Foundation

public extension String {
    func integerList() -> [Int] {
        return self.components(separatedBy: .newlines)
            .compactMap { Int($0) }
    }
    
    func doubleList() -> [Double] {
        return self.components(separatedBy: .newlines)
            .compactMap { Double($0) }
    }
}

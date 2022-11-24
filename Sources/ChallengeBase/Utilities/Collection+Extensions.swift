//
//  Arrays+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-07.
//

import Foundation

public extension Array where Element == String {
    var asResourceName: String {
        get {
            return self.joined(separator: ".")
        }
    }
}

public extension Array where Element == AnyObject {
    func cartesianProduct<V>(with rhs: Array<V>) -> [(Element, V)] {
        var prod: [(Element, V)] = []
        
        self.forEach { i in
            rhs.forEach { j in
                prod.append((i, j))
            }
        }
        
        return prod
    }
}

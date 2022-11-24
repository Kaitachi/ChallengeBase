//
//  Arrays+Extensions.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-07.
//

import Foundation

extension Array where Element == String {
    var asResourceName: String {
        get {
            return self.joined(separator: ".")
        }
    }
}


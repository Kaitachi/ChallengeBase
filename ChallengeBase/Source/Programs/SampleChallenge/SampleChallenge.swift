//
//  SampleChallenge.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-05.
//

import Foundation

enum SampleChallenge_Algorithms : String, CaseIterable {
    case part01
    case part02
}

enum SampleChallenge_Solutions : String, CaseIterable {
    case Solution00
}

class SampleChallenge : Challenge {
    typealias Algorithms = SampleChallenge_Algorithms
    typealias Solutions = SampleChallenge_Solutions
        
    var name: String {
        get { return "SampleChallenge" }
    }
    
    static func create(_ solution: Solutions, datasets: [String] = [], algorithms: [Algorithms] = []) -> any Solution {
        switch solution {
        case .Solution00:
            return SampleChallenge.Solution00(datasets: datasets, algorithms: algorithms)
        }
    }
}

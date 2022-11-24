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

protocol SampleChallenge : Challenge {
    var scenarios: [SampleChallenge_Algorithms]? { get set }
}

extension SampleChallenge {
    typealias Algorithms = SampleChallenge_Algorithms
    
    static var name: String {
        get { return "SampleChallenge" }
    }
}

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

protocol SampleChallenge : Challenge where Algorithms == SampleChallenge_Algorithms {
}

extension SampleChallenge {
    var name: String {
        get { return "SampleChallenge" }
    }
}

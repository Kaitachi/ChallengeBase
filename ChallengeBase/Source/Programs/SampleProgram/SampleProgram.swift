//
//  SampleProgram.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-05.
//

import Foundation

enum SampleProgram_Algorithms : String {
    case part01
    case part02
}

class SampleProgram : ChallengeSettings {
    typealias algorithms = SampleProgram_Algorithms
    
    static var challengeName: String {
        get { return "SampleProgram" }
    }
}

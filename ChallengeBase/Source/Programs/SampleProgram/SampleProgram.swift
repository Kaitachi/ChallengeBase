//
//  SampleProgram.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-11-05.
//

import Foundation

enum SampleProgram_Algorithms : String, CaseIterable {
    case part01
    case part02
}

protocol SampleProgram : Challenge {
    var scenarios: [SampleProgram_Algorithms]? { get set }
}

extension SampleProgram {
    typealias Algorithms = SampleProgram_Algorithms
    
    static var name: String {
        get { return "SampleProgram" }
    }
}

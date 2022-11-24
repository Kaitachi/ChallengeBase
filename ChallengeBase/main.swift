//
//  main.swift
//  ChallengeBase
//
//  Created by Radamés Vega-Alfaro on 2022-10-29.
//

import Foundation

let datasets = ["example"]

// MARK: - Direct Declaration
// Invoke using direct declarations
var declaredSolution = SampleChallenge.Solution00(datasets: datasets, algorithms: [.part01, .part02])

declaredSolution.execute()



// MARK: - Abstract Factory
// Invoke using abstract factory
var factorySolution = SampleChallenge.create(.Solution00, datasets: datasets, algorithms: [.part01, .part02])

factorySolution.execute()

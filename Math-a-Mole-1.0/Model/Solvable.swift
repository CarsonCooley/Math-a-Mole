//
//  Solvable.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

protocol Solvable {
    
    var questionParamMin: Int { get set }
    var questionParamMax: Int { get set }
    
    func solve()
    func setUp()
    
}

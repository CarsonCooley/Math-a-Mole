//
//  Flashcard.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

class Flashcard {
    let question: String
    let answer: Int
    
    var answerShowing: Bool = false
    var textShowing: String = ""
    
    init(question: String, answer: Int) {
        self.question = question
        self.answer = answer
        self.textShowing = question
    }
    
    func flip() {
        if self.answerShowing == false {
            self.answerShowing = true
            self.textShowing = "\(answer)"
        } else {
            self.answerShowing = false
            self.textShowing = question
        }
    }
}

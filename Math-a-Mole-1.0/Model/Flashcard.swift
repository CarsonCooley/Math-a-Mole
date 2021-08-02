//
//  Flashcard.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

class Flashcard {
    let question: MathQuestion
    
    var answerShowing: Bool = false
    var textShowing: String = ""
    
    init(question: MathQuestion) {
        self.question = question
        self.textShowing = question.toString()
    }
    
    func flip() {
        if self.answerShowing == false {
            self.answerShowing = true
            self.textShowing = "\(self.question.answer)"
        } else {
            self.answerShowing = false
            self.textShowing = self.question.toString()
        }
    }
}

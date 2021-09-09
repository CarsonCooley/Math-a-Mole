//
//  Flashcard.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

class Flashcard: Codable {
    let question: String
    let answer: Int
    var incorrectAnswer: Int
    
    var answerShowing: Bool = false
    var textShowing: String = ""
    
    init(question: String, answer: Int, incorrectAnswer: Int) {
        self.question = question
        self.answer = answer
        self.incorrectAnswer = incorrectAnswer
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

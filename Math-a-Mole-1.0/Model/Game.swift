//
//  Game.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

class Game {
    
    // MARK: - Global Variables
    
    var questionParamMin: Int
    var questionParamMax: Int
    var numMoles: Int
    
    var currentQuestion: MathQuestion? = nil
    var userAnswer: Int = -1
    var numCorrectAnswers: Int = 0
    var questionTypes: [MathQuestion] = [AddQuestion(), SubQuestion(), MultQuestion(), DivQuestion()]
    var moleArray: [Mole] = []
    var flashcards: [Flashcard] = []
    
    // MARK: - INIT
    
    init(numMoles: Int, questionParamMin: Int, questionParamMax: Int) {
        self.numMoles = numMoles
        self.questionParamMin = questionParamMin
        self.questionParamMax = questionParamMax
    }
    
    // MARK: - Game Methods
    
    func setUp() {
        for i in Range(1...numMoles) {
            let newMole = Mole(position: i)
            moleArray.append(newMole)
        }
    }
    
    func checkUserAnswer(userAnswer: Int) {
        if userAnswer == currentQuestion!.answer {
            numCorrectAnswers += 1
        }
    }
    
    func createQuestion() {
        print("A")
        currentQuestion = questionTypes.randomElement()
        print("B")
        currentQuestion?.generalSetUpAndSolve(questionParamMin: self.questionParamMin, questionParamMax: self.questionParamMax)
        print("C")
        currentQuestion?.setDummyAnswers()
        print("D")
    }
    
    func setMoles(dummyAnswers: [Int]) {
        
        var allAnswers = dummyAnswers
        allAnswers.append(currentQuestion!.answer)
        
        for answer in allAnswers {
            while true {
                let moleIndex = Int.random(in: 0...moleArray.count - 1)
                if moleArray[moleIndex].moleAnswer == -1 {
                    moleArray[moleIndex].moleAnswer = answer
                    break
                }
            }
        }
    }
    
    func resetMoles() {
        for mole in moleArray {
            mole.moleAnswer = -1
        }
    }
    
    func end() {
        currentQuestion = nil
        flashcards.removeAll()
        numCorrectAnswers = 0
    }
    
}

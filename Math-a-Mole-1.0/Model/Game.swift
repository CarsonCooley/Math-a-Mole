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
    var numIncorrectAnswers: Int = 0
    var totalScore: Int = 0
    var questionTypes: [MathQuestion] = [AddQuestion(), SubQuestion(), MultQuestion(), DivQuestion()]
    var moleArray: [Mole] = []
    var flashcards: [Flashcard] = []
    
    var time: Int = -1
    
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
            totalScore += 1
        } else {
            numIncorrectAnswers += 1
            if totalScore > 0 {
                totalScore -= 1
            }
            
            let newFlashcard = Flashcard(question: currentQuestion!.toString(), answer: currentQuestion!.answer, incorrectAnswer: userAnswer)
            flashcards.append(newFlashcard)
        }
    }
    
    func createQuestion() {
        currentQuestion = questionTypes.randomElement()
        currentQuestion?.generalSetUpAndSolve(questionParamMin: self.questionParamMin, questionParamMax: self.questionParamMax)
        currentQuestion?.setDummyAnswers()
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
    }
    
}

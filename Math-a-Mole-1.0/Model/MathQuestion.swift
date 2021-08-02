//
//  MathQuestion.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/29/21.
//

import Foundation

class MathQuestion {
    
    var no1: Int = -1
    var no2: Int = -1
    var operation: String = "none"
    var answer: Int = -1
    var answeredCorrectly: Bool = false
    var dummyAnswers: [Int] = []
    
    func generalSetUpAndSolve() {
        if let question = self as? AddQuestion {
            question.setUp()
            question.solve()
        } else if let question = self as? SubQuestion {
            question.setUp()
            question.solve()
        } else if let question = self as? MultQuestion {
            question.setUp()
            question.solve()
        } else if let question = self as? DivQuestion {
            question.setUp()
            question.solve()
        }
    }
    
    func setDummyAnswers() {
        
        if self is AddQuestion {
            dummyAddQuestions()
        } else if self is SubQuestion {
            dummySubQuestions()
        } else if self is MultQuestion {
            dummyMultQuestions()
        } else if self is DivQuestion {
            dummyDivQuestions()
        }
    }
    
    func dummyAddQuestions() {
        
        if self.answer == 0 {
            dummyAnswers.append(2)
        } else {
            dummyAnswers.append(self.answer - 1)
        }
        
        dummyAnswers.append(self.answer + 1)
        
    }
    
    func dummySubQuestions() {
        
        if self.answer == 0 {
            dummyAnswers.append(2)
        } else {
            dummyAnswers.append(self.answer - 1)
        }
        
        dummyAnswers.append(self.answer + 1)
        
    }
    
    func dummyMultQuestions() {

        if self.no1 == 0 && self.no2 == 0 {     // 0 * 0
            dummyAnswers.append(1)
            dummyAnswers.append(2)
        } else if self.answer == 0 {            // 0 * 5
            if self.no1 == 0 {
                dummyAnswers.append(self.no2)
                dummyAnswers.append(self.no2 + 1)
            } else {
                dummyAnswers.append(self.no1)
                dummyAnswers.append(self.no1 + 1)
            }
        } else {                                // 2 * 3
            dummyAnswers.append(self.answer + self.no1)
            dummyAnswers.append(self.answer - self.no2)
        }

    }
    
    func dummyDivQuestions() {

        if self.answer == 0 {                   // 0 / 5
            dummyAnswers.append(self.no2)
            dummyAnswers.append(1)
        } else if self.answer == 1 {
            if self.no1 == 1 && self.no2 == 1 { // 1 / 1
                dummyAnswers.append(0)
                dummyAnswers.append(2)
            } else {                            // 5 / 5
                dummyAnswers.append(0)
                dummyAnswers.append(self.no1)
            }
        } else {                                // 10 / 5
            dummyAnswers.append(self.answer - 1)
            dummyAnswers.append(self.answer + 1)
        }

    }
    
    func toString() -> String {
        return "\(no1) \(operation) \(no2)"
    }
    
}

class AddQuestion: MathQuestion, Solvable {
    
    var questionParamMin: Int = 0
    
    var questionParamMax: Int = 10
    
    func setUp() {
        self.operation = "+"
        self.no1 = Int.random(in: questionParamMin...questionParamMax)
        self.no2 = Int.random(in: questionParamMin...questionParamMax)
    }
    
    func solve() {
        self.answer = no1 + no2
    }
}

class SubQuestion: MathQuestion, Solvable {
    
    var questionParamMin: Int = 0
    
    var questionParamMax: Int = 10
    
    
    func setUp() {
        
        self.operation = "-"
        
        while true {
            
            // Create a subtraction problem and then translate into an addition problem
            let reverseProblem = AddQuestion()
            reverseProblem.setUp()
            reverseProblem.solve()
            
            self.no1 = reverseProblem.answer
            self.no2 = reverseProblem.no2
            self.answer = reverseProblem.no1
            
            if (self.no2 != 0) {
                break
            }
        }
    }
    
    func solve() {
        self.answer = no1 - no2
    }
}

class MultQuestion: MathQuestion, Solvable {
    
    var questionParamMin: Int = 0
    
    var questionParamMax: Int = 10
    
    
    func setUp() {
        self.operation = "*"
        self.no1 = Int.random(in: questionParamMin...questionParamMax)
        self.no2 = Int.random(in: questionParamMin...questionParamMax)
    }
    
    func solve() {
        self.answer = no1 * no2
    }

}

class DivQuestion: MathQuestion, Solvable {
    
    var questionParamMin: Int = 0
    
    var questionParamMax: Int = 10
    
    func setUp() {
        
        self.operation = "/"
        
        while true {
            
            // Create a multiplication problem and then translate into a division problem
            let reverseProblem = MultQuestion()
            reverseProblem.setUp()
            reverseProblem.solve()
            
            self.no1 = reverseProblem.answer
            self.no2 = reverseProblem.no2
            self.answer = reverseProblem.no1
            
            if (self.no2 != 0) {
                break
            }
        }
    }
    
    func solve() {
        self.answer = no1 / no2
    }
    
}

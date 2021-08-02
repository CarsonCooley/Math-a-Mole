//
//  ViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/2/21.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var moleView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var moleViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var whatIsLabel: UILabel!
    
    @IBOutlet weak var mole1: UIButton!
    @IBOutlet weak var mole2: UIButton!
    @IBOutlet weak var mole3: UIButton!
    @IBOutlet weak var mole4: UIButton!
    @IBOutlet weak var mole5: UIButton!
    @IBOutlet weak var mole6: UIButton!
    @IBOutlet weak var mole7: UIButton!
    @IBOutlet weak var mole8: UIButton!
    @IBOutlet weak var mole9: UIButton!
    @IBOutlet weak var mole10: UIButton!
    @IBOutlet weak var mole11: UIButton!
    @IBOutlet weak var mole12: UIButton!
    
    @IBOutlet weak var moleStack: UIStackView!
    
    var timer = Timer()
    var totalTime = 10
    var secondsRemaining = 10
    
    var game = Game(numMoles: 0, questionParamMin: 0, questionParamMax: 0)
        
    var views: [UIView] = []
    var moleButtons: [UIButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        moleStack.isHidden = true
        
        moleButtons = [mole1, mole2, mole3, mole4, mole5, mole6, mole7, mole8, mole9, mole10, mole11, mole12]
        
        views = [topView, moleView, bottomView]
        for view in views {
            view.backgroundColor = UIColor.clear
        }
        
        topViewHeight.constant = mainView.frame.size.height / 5
        moleViewHeight.constant = mainView.frame.size.height / 10 * 7
        bottomViewHeight.constant = mainView.frame.size.height / 10
        
        questionLabel.numberOfLines = 3
        questionLabel.text = "Press the 'START' button to begin"
        whatIsLabel.text = "MATH-A-MOLE"
        
        game.numMoles = 12
        game.questionParamMin = 0
        game.questionParamMax = 10
        
        game.setUp()
        
    }
    
    @IBAction func molePressed(_ sender: UIButton) {
        game.checkUserAnswer(userAnswer: Int(sender.currentTitle!)!)
        game.currentQuestion?.dummyAnswers.removeAll()
        game.resetMoles()
        game.createQuestion()
        print(game.currentQuestion!.toString())
        print(game.currentQuestion!.dummyAnswers)
        print(game.currentQuestion!.answer)
        print("")
        game.setMoles(dummyAnswers: game.currentQuestion!.dummyAnswers)
        
        self.updateUI()
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        game.resetMoles()
        game.createQuestion()
        print(game.currentQuestion!.toString())
        print(game.currentQuestion!.dummyAnswers)
        print(game.currentQuestion!.dummyAnswers)
        game.setMoles(dummyAnswers: game.currentQuestion!.dummyAnswers)
        self.updateUI()
        
        startButton.isHidden = true
        moleStack.isHidden = false
        whatIsLabel.text = "What is..."
        
        totalTime = 100
        secondsRemaining = totalTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        let progressPercentage = Float(secondsRemaining) / Float(totalTime)
        
        progressBar.progress = Float(progressPercentage)
        
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            startButton.isHidden = false
            moleStack.isHidden = true
            questionLabel.text = "Moles Mathed: \(game.numCorrectAnswers)"
            game.end()
        }
    }
    
    func updateUI() {
        questionLabel.text = game.currentQuestion?.toString()
        self.updateMoleArray()
    }
    
    func updateMoleArray() {
        var index: Int = 0
        for moleButton in moleButtons {
            moleButton.setTitle("\(game.moleArray[index].moleAnswer)", for: .normal)
            index += 1
            if moleButton.currentTitle == "-1" {
                moleButton.alpha = 0.0
            } else {
                moleButton.alpha = 1.0
            }
        }
    }
}


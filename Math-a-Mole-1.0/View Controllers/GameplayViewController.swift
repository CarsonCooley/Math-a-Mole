//
//  ViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 7/2/21.
//

import UIKit

class GameplayViewController: UIViewController {
    
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
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
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
    var gameDifficulty: String = ""
    
    var views: [UIView] = []
    var moleButtons: [UIButton] = []
    
    var highScores: [Int] = [0, 0, 0, 0]
    var highScore: Int = 0
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topViewHeight.constant = mainView.frame.size.height / 20 * 7
        moleViewHeight.constant = mainView.frame.size.height / 20 * 10
        bottomViewHeight.constant = mainView.frame.size.height / 20 * 3
        progressBar.transform = progressBar.transform.scaledBy(x: 1, y: 5)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scores = defaults.array(forKey: "HighScoresArray") as? [Int] {
            highScores = scores
        }
        
        for score in highScores {
            print(score)
        }
        
        exitButton.isEnabled = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        startButton.layer.cornerRadius = 10
        startButton.clipsToBounds = true
        
        moleStack.isHidden = false
        
        moleButtons = [mole1, mole2, mole3, mole4, mole5, mole6, mole7, mole8, mole9, mole10, mole11, mole12]
        
        for moleButton in moleButtons {
            moleButton.isEnabled = false
        }
        
        views = [topView, moleView, bottomView]
        for view in views {
            view.backgroundColor = UIColor.clear
        }
        
        questionLabel.numberOfLines = 3
        questionLabel.text = ""
        whatIsLabel.text = ""
        
        self.setGameParameters()
        
        game.setUp()
        
    }
    
    func setGameParameters() {
        if gameDifficulty == "Beginner" {
            game.numMoles = 12
            game.questionTypes = [AddQuestion(), SubQuestion()]
            game.questionParamMin = 0
            game.questionParamMax = 5
            game.time = 10
        } else if gameDifficulty == "Intermediate" {
            game.numMoles = 12
            game.questionTypes = [AddQuestion(), SubQuestion()]
            game.questionParamMin = 0
            game.questionParamMax = 10
            game.time = 60
        } else if gameDifficulty == "Advanced" {
            game.numMoles = 12
            game.questionTypes = [MultQuestion(), DivQuestion()]
            game.questionParamMin = 0
            game.questionParamMax = 10
            game.time = 10
        } else if gameDifficulty == "Expert" {
            game.numMoles = 12
            game.questionTypes = [AddQuestion(), SubQuestion(), MultQuestion(), DivQuestion()]
            game.questionParamMin = 0
            game.questionParamMax = 10
            game.time = 20
        } else {
            print("ERROR: game difficulty not captured")
        }
    }
    
    @IBAction func molePressed(_ sender: UIButton) {
        game.checkUserAnswer(userAnswer: Int(sender.currentTitle!) ?? -1)
        game.currentQuestion?.dummyAnswers.removeAll()
        game.resetMoles()
        game.createQuestion()
        game.setMoles(dummyAnswers: game.currentQuestion!.dummyAnswers)
        
        self.updateUI()
    }
    
    @IBAction func exitPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func startPressed(_ sender: UIButton) {
        if sender.currentTitle! == "START" {
            
            for moleButton in moleButtons {
                moleButton.isEnabled = true
            }
            
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.hidesBackButton = true
            
            exitButton.isEnabled = false
            
            game.resetMoles()
            game.createQuestion()
            game.setMoles(dummyAnswers: game.currentQuestion!.dummyAnswers)
            
            self.updateUI()
            self.moleStack.isHidden = false
            self.whatIsLabel.text = "What is..."
            
            totalTime = game.time
            secondsRemaining = totalTime
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            
            sender.setTitle("PAUSE", for: .normal)
            
        } else if sender.currentTitle! == "PAUSE" || sender.currentTitle! == "RESUME" {
            if sender.currentTitle! == "PAUSE" {
                sender.setTitle("RESUME", for: .normal)
                game.currentQuestion?.dummyAnswers.removeAll()
                game.currentQuestion = nil
                game.resetMoles()
                game.createQuestion()
                game.setMoles(dummyAnswers: game.currentQuestion!.dummyAnswers)
                
                self.updateUI()
                self.moleStack.isHidden = true
                self.questionLabel.isHidden = true
                self.whatIsLabel.text = "Game is paused"
                exitButton.isEnabled = true
                timer.invalidate()
            } else {
                sender.setTitle("PAUSE", for: .normal)
                self.moleStack.isHidden = false
                self.questionLabel.isHidden = false
                self.whatIsLabel.text = "What is..."
                exitButton.isEnabled = false
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! StatisticsViewController
        vc.flashcards = self.game.flashcards
        vc.numCorrectAnswers = self.game.numCorrectAnswers
        vc.numIncorrectAnswers = self.game.numIncorrectAnswers
        vc.totalScore = self.game.totalScore
        print(self.highScore)
        vc.highScore = self.highScore
    }
    
    @objc func updateCounter() {
        let progressPercentage = Float(secondsRemaining) / Float(totalTime)
        self.progressBar.progress = Float(progressPercentage)
        
        if secondsRemaining > 0 {
            secondsRemaining -= 1
        } else {
            timer.invalidate()
            self.startButton.isHidden = false
            self.moleStack.isHidden = true
            self.updateHighScores()
            game.end()
            self.defaults.set(self.highScores, forKey: "HighScoresArray")
            performSegue(withIdentifier: K.Segues.advanceToStatistics, sender: self)
        }
    }
    
    func updateHighScores() {
        var highScoreIndex = -1
        if gameDifficulty == "Beginner" {
            highScoreIndex = 0
        } else if gameDifficulty == "Intermediate" {
            highScoreIndex = 1
        } else if gameDifficulty == "Advanced" {
            highScoreIndex = 2
        } else if gameDifficulty == "Expert" {
            highScoreIndex = 3
        } else {
            print("ERROR: game difficulty not captured")
        }
        
        for score in highScores {
            print(score)
        }
        
        print()
        
        if game.totalScore > highScores[highScoreIndex] {
            highScores[highScoreIndex] = game.totalScore
        }
        
        highScore = highScores[highScoreIndex]
        
        for score in highScores {
            print(score)
        }
        
        print()
        
        print(highScore)
    }
    
    func updateUI() {
        self.questionLabel.text = self.game.currentQuestion?.toString()
        self.updateMoleArray()
    }
    
    func updateMoleArray() {
        var index: Int = 0
        for moleButton in self.moleButtons {
            moleButton.setTitle("\(self.game.moleArray[index].moleAnswer)", for: .normal)
            index += 1
            if moleButton.currentTitle == "-1" {
                moleButton.setBackgroundImage(UIImage(named: "emptyMoleHole.pdf"), for: .normal)
                moleButton.setTitle("", for: .normal)
                moleButton.isEnabled = false
                moleButton.alpha = 1.0
            } else {
                moleButton.setBackgroundImage(UIImage(named: "mole.pdf"), for: .normal)
                moleButton.isEnabled = true
            }
        }
    }
}


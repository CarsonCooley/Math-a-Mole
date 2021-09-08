//
//  StatisticsViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 9/3/21.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var gameOverLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var flashcards: [Flashcard] = []
    var numCorrectAnswers: Int = 0
    var numIncorrectAnswers: Int = 0
    var totalScore: Int = 0
    var highScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        correctLabel.text = "Correct Answers: \(numCorrectAnswers)"
        incorrectLabel.text = "Incorrect Answers: \(numIncorrectAnswers)"
        scoreLabel.text = "Total Score: \(totalScore)"
        highScoreLabel.text = "Record High Score: \(highScore)"
    }
    
    @IBAction func nextPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segues.advanceToGameFC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CurrentGameFCViewController
        vc.flashcards = self.flashcards
    }
    
    

}

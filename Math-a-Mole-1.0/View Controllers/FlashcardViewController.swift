//
//  FlashcardViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 8/11/21.
//

import UIKit

class CurrentGameViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var incorrectAnswerLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var views: [UIView] = []
    
    var flashcards: [Flashcard] = []
    var currentFlashcardIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        incorrectAnswerLabel.isHidden = true
        topView.layer.cornerRadius = 20
        topView.clipsToBounds = true
        self.updateFlashcard(change: 0)
        views = [topView, bottomView]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
        flashcards[currentFlashcardIndex].flip()
        self.incorrectAnswerLabel.isHidden = !self.incorrectAnswerLabel.isHidden
        self.updateFlashcard(change: 0)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        updateFlashcard(change: 1)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        updateFlashcard(change: -1)
    }
    
    @IBAction func homeButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func allCardsPressed(_ sender: UIBarButtonItem) {
        
    }
    
    func updateFlashcard(change: Int) {
        if flashcards.count == 0 {
            questionLabel.text = "No Flashcards"
            forwardButton.isHidden = true
            backButton.isHidden = true
            flipButton.isHidden = true
            progressLabel.isHidden = true
            incorrectAnswerLabel.isHidden = true
        }
        
        if (currentFlashcardIndex + change >= 0) && (currentFlashcardIndex + change < flashcards.count) {
            
            currentFlashcardIndex += change
            
            questionLabel.text = flashcards[currentFlashcardIndex].textShowing
            progressLabel.text = "\(currentFlashcardIndex + 1) / \(flashcards.count)"
            
            if questionLabel.text?.count ?? -1 > 2 {
                incorrectAnswerLabel.isHidden = true
            } else {
                incorrectAnswerLabel.text = "You Answered: \(flashcards[currentFlashcardIndex].incorrectAnswer)"
                incorrectAnswerLabel.isHidden = false
            }
            
        }
    }
    
}

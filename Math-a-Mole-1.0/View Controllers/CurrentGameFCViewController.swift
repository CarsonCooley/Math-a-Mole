//
//  FlashcardViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 8/11/21.
//

import UIKit

class CurrentGameFCViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var incorrectAnswerLabel: UILabel!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var views: [UIView] = []
    
    var currentGameFlashcards: [Flashcard] = []
    var dataPersistantFlashcards: [Flashcard] = []
    var currentFlashcardIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        views = [topView, bottomView]
        
        incorrectAnswerLabel.isHidden = true
        topView.layer.cornerRadius = 20
        topView.clipsToBounds = true
        
        navigationController?.navigationItem.backBarButtonItem?.title = "Back"
        navigationController?.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        
        self.updateFlashcard(change: 0)
        
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
        currentGameFlashcards[currentFlashcardIndex].flip()
        self.incorrectAnswerLabel.isHidden = !self.incorrectAnswerLabel.isHidden
        self.updateFlashcard(change: 0)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if currentFlashcardIndex == currentGameFlashcards.count - 1 {
            currentFlashcardIndex = 0
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: 1)
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        if currentFlashcardIndex == 0 {
            currentFlashcardIndex = currentGameFlashcards.count - 1
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: -1)
        }
        
    }
    
    @IBAction func allCardsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segues.advanceToCumulativeFC, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CumulativeFCViewController
        vc.dataPersistantFlashcards = self.dataPersistantFlashcards
    }
    
    @IBAction func shufflePressed(_ sender: UIButton) {
        currentGameFlashcards.shuffle()
        currentFlashcardIndex = 0
        updateFlashcard(change: 0)
    }
    
    func updateFlashcard(change: Int) {
        if currentGameFlashcards.count == 0 {
            questionLabel.text = "No Flashcards"
            forwardButton.isHidden = true
            backButton.isHidden = true
            flipButton.isHidden = true
            progressLabel.isHidden = true
            incorrectAnswerLabel.isHidden = true
        } else if (currentFlashcardIndex + change >= 0) && (currentFlashcardIndex + change < currentGameFlashcards.count) {
            
            if questionLabel.text == "\(currentGameFlashcards[currentFlashcardIndex].answer)" && change != 0 {
                currentGameFlashcards[currentFlashcardIndex].flip()
            }
            
            currentFlashcardIndex += change
            
            questionLabel.text = currentGameFlashcards[currentFlashcardIndex].textShowing
            progressLabel.text = "\(currentFlashcardIndex + 1) / \(currentGameFlashcards.count)"
            
            if questionLabel.text?.count ?? -1 > 2 {
                incorrectAnswerLabel.isHidden = true
            } else {
                incorrectAnswerLabel.text = "You Answered: \(currentGameFlashcards[currentFlashcardIndex].incorrectAnswer)"
                incorrectAnswerLabel.isHidden = false
            }
        }
    }
}

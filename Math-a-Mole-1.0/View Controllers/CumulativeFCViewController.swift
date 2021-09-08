//
//  CumulativeFCViewController.swift
//  Math-a-Mole-1.0
//
//  Created by Carson Cooley on 9/3/21.
//

import UIKit

class CumulativeFCViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var flipButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    var views: [UIView] = []
    
    var flashcards: [Flashcard] = []
    var currentFlashcardIndex = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        topView.layer.cornerRadius = 20
        topView.clipsToBounds = true
        self.updateFlashcard(change: 0)
        views = [topView, bottomView]
    }
    

    @IBAction func homePressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func shufflePressed(_ sender: UIButton) {
        flashcards.shuffle()
        currentFlashcardIndex = 0
        updateFlashcard(change: 0)
    }
    
    @IBAction func trashPressed(_ sender: UIButton) {
        flashcards.remove(at: currentFlashcardIndex)
        updateFlashcard(change: 0)
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        if currentFlashcardIndex == 0 {
            currentFlashcardIndex = flashcards.count - 1
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: -1)
        }
    }
    
    @IBAction func flipPressed(_ sender: UIButton) {
        flashcards[currentFlashcardIndex].flip()
        self.updateFlashcard(change: 0)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        if currentFlashcardIndex == flashcards.count - 1 {
            currentFlashcardIndex = 0
            updateFlashcard(change: 0)
        } else {
            updateFlashcard(change: 1)
        }
    }
    
    func updateFlashcard(change: Int) {
        if flashcards.count == 0 {
            questionLabel.text = "No Flashcards"
            forwardButton.isHidden = true
            backButton.isHidden = true
            flipButton.isHidden = true
            progressLabel.isHidden = true
            trashButton.isHidden = true
            shuffleButton.isHidden = true
        } else if currentFlashcardIndex == flashcards.count {
            currentFlashcardIndex -= 1
        }

        if (currentFlashcardIndex + change >= 0) && (currentFlashcardIndex + change < flashcards.count) {
            
            currentFlashcardIndex += change
            
            questionLabel.text = flashcards[currentFlashcardIndex].textShowing
            progressLabel.text = "\(currentFlashcardIndex + 1) / \(flashcards.count)"
        }
    }
    
}
